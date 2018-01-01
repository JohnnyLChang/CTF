





<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
  <link rel="dns-prefetch" href="https://assets-cdn.github.com">
  <link rel="dns-prefetch" href="https://avatars0.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars1.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars2.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars3.githubusercontent.com">
  <link rel="dns-prefetch" href="https://github-cloud.s3.amazonaws.com">
  <link rel="dns-prefetch" href="https://user-images.githubusercontent.com/">



  <link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/frameworks-1c2c316b7a17f15536c6a26ed744654fc228a24658a7ae395cdcbf8329c8406b.css" media="all" rel="stylesheet" />
  <link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/github-8100b9bf1eb6ed8b38eaad2fe7ba51d1895aa0602aafe4a87068d444e07e8c5c.css" media="all" rel="stylesheet" />
  
  
  <link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/site-44b6bba3881278f33c221b6526379b55fbd098af3e553f54e81cab4c9a517c8e.css" media="all" rel="stylesheet" />
  

  <meta name="viewport" content="width=device-width">
  
  <title>Padding-oracle-attack/README.md at master · JohnnyLChang/Padding-oracle-attack · GitHub</title>
  <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
  <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
  <meta property="fb:app_id" content="1401488693436528">

    
    <meta content="https://avatars1.githubusercontent.com/u/5090551?s=400&amp;v=4" property="og:image" /><meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="JohnnyLChang/Padding-oracle-attack" property="og:title" /><meta content="https://github.com/JohnnyLChang/Padding-oracle-attack" property="og:url" /><meta content="Padding-oracle-attack - Padding oracle attack against PKCS7" property="og:description" />

  <link rel="assets" href="https://assets-cdn.github.com/">
  
  <meta name="pjax-timeout" content="1000">
  
  <meta name="request-id" content="D0F2:3540:C0DC6CA:1478998B:5A4A4A2C" data-pjax-transient>
  

  <meta name="selected-link" value="repo_source" data-pjax-transient>

    <meta name="google-site-verification" content="KT5gs8h0wvaagLKAVWq8bbeNwnZZK1r1XQysX3xurLU">
  <meta name="google-site-verification" content="ZzhVyEFwb7w3e0-uOTltm8Jsck2F5StVihD0exw2fsA">
  <meta name="google-site-verification" content="GXs5KoUUkNCoaAZn7wPN-t01Pywp9M3sEjnt_3_ZWPc">
    <meta name="google-analytics" content="UA-3769691-2">

<meta content="collector.githubapp.com" name="octolytics-host" /><meta content="github" name="octolytics-app-id" /><meta content="https://collector.githubapp.com/github-external/browser_event" name="octolytics-event-url" /><meta content="D0F2:3540:C0DC6CA:1478998B:5A4A4A2C" name="octolytics-dimension-request_id" /><meta content="iad" name="octolytics-dimension-region_edge" /><meta content="iad" name="octolytics-dimension-region_render" />
<meta content="/&lt;user-name&gt;/&lt;repo-name&gt;/blob/show" data-pjax-transient="true" name="analytics-location" />




  <meta class="js-ga-set" name="dimension1" content="Logged Out">


  

      <meta name="hostname" content="github.com">
  <meta name="user-login" content="">

      <meta name="expected-hostname" content="github.com">
    <meta name="js-proxy-site-detection-payload" content="MzNjNmNhZjQ3YzgyYWYyMzVjMGU5MGU0YmFmNWQ2Nzk4ODFiZmE2YjYxYjNiMWJhZWQxNWExMzI4MDdmZGFlYnx7InJlbW90ZV9hZGRyZXNzIjoiNjEuMjMxLjg4LjIzNCIsInJlcXVlc3RfaWQiOiJEMEYyOjM1NDA6QzBEQzZDQToxNDc4OTk4Qjo1QTRBNEEyQyIsInRpbWVzdGFtcCI6MTUxNDgxODA5MywiaG9zdCI6ImdpdGh1Yi5jb20ifQ==">


  <meta name="html-safe-nonce" content="7121fdf1d0683a93128d7aa07bd4b71464ab7830">

  <meta http-equiv="x-pjax-version" content="e6dbf537b2eb3990c0cae54500f32daf">
  

      <link href="https://github.com/JohnnyLChang/Padding-oracle-attack/commits/master.atom" rel="alternate" title="Recent Commits to Padding-oracle-attack:master" type="application/atom+xml">

  <meta name="description" content="Padding-oracle-attack - Padding oracle attack against PKCS7">
  <meta name="go-import" content="github.com/JohnnyLChang/Padding-oracle-attack git https://github.com/JohnnyLChang/Padding-oracle-attack.git">

  <meta content="5090551" name="octolytics-dimension-user_id" /><meta content="JohnnyLChang" name="octolytics-dimension-user_login" /><meta content="115925249" name="octolytics-dimension-repository_id" /><meta content="JohnnyLChang/Padding-oracle-attack" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="true" name="octolytics-dimension-repository_is_fork" /><meta content="49711754" name="octolytics-dimension-repository_parent_id" /><meta content="mpgn/Padding-oracle-attack" name="octolytics-dimension-repository_parent_nwo" /><meta content="49711754" name="octolytics-dimension-repository_network_root_id" /><meta content="mpgn/Padding-oracle-attack" name="octolytics-dimension-repository_network_root_nwo" /><meta content="false" name="octolytics-dimension-repository_explore_github_marketplace_ci_cta_shown" />


    <link rel="canonical" href="https://github.com/JohnnyLChang/Padding-oracle-attack/blob/master/README.md" data-pjax-transient>


  <meta name="browser-stats-url" content="https://api.github.com/_private/browser/stats">

  <meta name="browser-errors-url" content="https://api.github.com/_private/browser/errors">

  <link rel="mask-icon" href="https://assets-cdn.github.com/pinned-octocat.svg" color="#000000">
  <link rel="icon" type="image/x-icon" class="js-site-favicon" href="https://assets-cdn.github.com/favicon.ico">

<meta name="theme-color" content="#1e2327">



  </head>

  <body class="logged-out env-production page-blob">
    

  <div class="position-relative js-header-wrapper ">
    <a href="#start-of-content" tabindex="1" class="px-2 py-4 show-on-focus js-skip-to-content">Skip to content</a>
    <div id="js-pjax-loader-bar" class="pjax-loader-bar"><div class="progress"></div></div>

    
    
    
      



        <header class="Header header-logged-out  position-relative f4 py-3" role="banner">
  <div class="container-lg d-flex px-3">
    <div class="d-flex flex-justify-between flex-items-center">
      <a class="header-logo-invertocat my-0" href="https://github.com/" aria-label="Homepage" data-ga-click="(Logged out) Header, go to homepage, icon:logo-wordmark">
        <svg aria-hidden="true" class="octicon octicon-mark-github" height="32" version="1.1" viewBox="0 0 16 16" width="32"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"/></svg>
      </a>

    </div>

    <div class="HeaderMenu HeaderMenu--bright d-flex flex-justify-between flex-auto">
        <nav class="mt-0">
          <ul class="d-flex list-style-none">
              <li class="ml-2">
                <a href="/features" class="js-selected-navigation-item HeaderNavlink px-0 py-2 m-0" data-ga-click="Header, click, Nav menu - item:features" data-selected-links="/features /features/project-management /features/code-review /features/project-management /features/integrations /features">
                  Features
</a>              </li>
              <li class="ml-4">
                <a href="/business" class="js-selected-navigation-item HeaderNavlink px-0 py-2 m-0" data-ga-click="Header, click, Nav menu - item:business" data-selected-links="/business /business/security /business/customers /business">
                  Business
</a>              </li>

              <li class="ml-4">
                <a href="/explore" class="js-selected-navigation-item HeaderNavlink px-0 py-2 m-0" data-ga-click="Header, click, Nav menu - item:explore" data-selected-links="/explore /trending /trending/developers /integrations /integrations/feature/code /integrations/feature/collaborate /integrations/feature/ship showcases showcases_search showcases_landing /explore">
                  Explore
</a>              </li>

              <li class="ml-4">
                    <a href="/marketplace" class="js-selected-navigation-item HeaderNavlink px-0 py-2 m-0" data-ga-click="Header, click, Nav menu - item:marketplace" data-selected-links=" /marketplace">
                      Marketplace
</a>              </li>
              <li class="ml-4">
                <a href="/pricing" class="js-selected-navigation-item HeaderNavlink px-0 py-2 m-0" data-ga-click="Header, click, Nav menu - item:pricing" data-selected-links="/pricing /pricing/developer /pricing/team /pricing/business-hosted /pricing/business-enterprise /pricing">
                  Pricing
</a>              </li>
          </ul>
        </nav>

      <div class="d-flex">
          <div class="d-lg-flex flex-items-center mr-3">
            <div class="header-search scoped-search site-scoped-search js-site-search" role="search">
  <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/JohnnyLChang/Padding-oracle-attack/search" class="js-site-search-form" data-scoped-search-url="/JohnnyLChang/Padding-oracle-attack/search" data-unscoped-search-url="/search" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
    <label class="form-control header-search-wrapper js-chromeless-input-container">
        <a href="/JohnnyLChang/Padding-oracle-attack/blob/master/README.md" class="header-search-scope no-underline">This repository</a>
      <input type="text"
        class="form-control header-search-input js-site-search-focus js-site-search-field is-clearable"
        data-hotkey="s"
        name="q"
        value=""
        placeholder="Search"
        aria-label="Search this repository"
        data-unscoped-placeholder="Search GitHub"
        data-scoped-placeholder="Search"
        autocapitalize="off">
        <input type="hidden" class="js-site-search-type-field" name="type" >
    </label>
</form></div>

          </div>

        <span class="d-inline-block">
            <div class="HeaderNavlink px-0 py-2 m-0">
              <a class="text-bold text-white no-underline" href="/login?return_to=%2FJohnnyLChang%2FPadding-oracle-attack%2Fblob%2Fmaster%2FREADME.md" data-ga-click="(Logged out) Header, clicked Sign in, text:sign-in">Sign in</a>
                <span class="text-gray">or</span>
                <a class="text-bold text-white no-underline" href="/join?source=header-repo" data-ga-click="(Logged out) Header, clicked Sign up, text:sign-up">Sign up</a>
            </div>
        </span>
      </div>
    </div>
  </div>
</header>


  </div>

  <div id="start-of-content" class="show-on-focus"></div>

    <div id="js-flash-container">
</div>



  <div role="main">
        <div itemscope itemtype="http://schema.org/SoftwareSourceCode">
    <div id="js-repo-pjax-container" data-pjax-container>
      





  <div class="pagehead repohead instapaper_ignore readability-menu experiment-repo-nav ">
    <div class="repohead-details-container clearfix container ">

      <ul class="pagehead-actions">
  <li>
      <a href="/login?return_to=%2FJohnnyLChang%2FPadding-oracle-attack"
    class="btn btn-sm btn-with-count tooltipped tooltipped-n"
    aria-label="You must be signed in to watch a repository" rel="nofollow">
    <svg aria-hidden="true" class="octicon octicon-eye" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"/></svg>
    Watch
  </a>
  <a class="social-count" href="/JohnnyLChang/Padding-oracle-attack/watchers"
     aria-label="1 user is watching this repository">
    1
  </a>

  </li>

  <li>
      <a href="/login?return_to=%2FJohnnyLChang%2FPadding-oracle-attack"
    class="btn btn-sm btn-with-count tooltipped tooltipped-n"
    aria-label="You must be signed in to star a repository" rel="nofollow">
    <svg aria-hidden="true" class="octicon octicon-star" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74z"/></svg>
    Star
  </a>

    <a class="social-count js-social-count" href="/JohnnyLChang/Padding-oracle-attack/stargazers"
      aria-label="0 users starred this repository">
      0
    </a>

  </li>

  <li>
      <a href="/login?return_to=%2FJohnnyLChang%2FPadding-oracle-attack"
        class="btn btn-sm btn-with-count tooltipped tooltipped-n"
        aria-label="You must be signed in to fork a repository" rel="nofollow">
        <svg aria-hidden="true" class="octicon octicon-repo-forked" height="16" version="1.1" viewBox="0 0 10 16" width="10"><path fill-rule="evenodd" d="M8 1a1.993 1.993 0 0 0-1 3.72V6L5 8 3 6V4.72A1.993 1.993 0 0 0 2 1a1.993 1.993 0 0 0-1 3.72V6.5l3 3v1.78A1.993 1.993 0 0 0 5 15a1.993 1.993 0 0 0 1-3.72V9.5l3-3V4.72A1.993 1.993 0 0 0 8 1zM2 4.2C1.34 4.2.8 3.65.8 3c0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3 10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3-10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2z"/></svg>
        Fork
      </a>

    <a href="/JohnnyLChang/Padding-oracle-attack/network" class="social-count"
       aria-label="10 users forked this repository">
      10
    </a>
  </li>
</ul>

      <h1 class="public ">
  <svg aria-hidden="true" class="octicon octicon-repo-forked" height="16" version="1.1" viewBox="0 0 10 16" width="10"><path fill-rule="evenodd" d="M8 1a1.993 1.993 0 0 0-1 3.72V6L5 8 3 6V4.72A1.993 1.993 0 0 0 2 1a1.993 1.993 0 0 0-1 3.72V6.5l3 3v1.78A1.993 1.993 0 0 0 5 15a1.993 1.993 0 0 0 1-3.72V9.5l3-3V4.72A1.993 1.993 0 0 0 8 1zM2 4.2C1.34 4.2.8 3.65.8 3c0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3 10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3-10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2z"/></svg>
  <span class="author" itemprop="author"><a href="/JohnnyLChang" class="url fn" rel="author">JohnnyLChang</a></span><!--
--><span class="path-divider">/</span><!--
--><strong itemprop="name"><a href="/JohnnyLChang/Padding-oracle-attack" data-pjax="#js-repo-pjax-container">Padding-oracle-attack</a></strong>

    <span class="fork-flag">
      <span class="text">forked from <a href="/mpgn/Padding-oracle-attack">mpgn/Padding-oracle-attack</a></span>
    </span>
</h1>

    </div>
    
<nav class="reponav js-repo-nav js-sidenav-container-pjax container"
     itemscope
     itemtype="http://schema.org/BreadcrumbList"
     role="navigation"
     data-pjax="#js-repo-pjax-container">

  <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
    <a href="/JohnnyLChang/Padding-oracle-attack" class="js-selected-navigation-item selected reponav-item" data-hotkey="g c" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches repo_packages /JohnnyLChang/Padding-oracle-attack" itemprop="url">
      <svg aria-hidden="true" class="octicon octicon-code" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M9.5 3L8 4.5 11.5 8 8 11.5 9.5 13 14 8 9.5 3zm-5 0L0 8l4.5 5L6 11.5 2.5 8 6 4.5 4.5 3z"/></svg>
      <span itemprop="name">Code</span>
      <meta itemprop="position" content="1">
</a>  </span>


  <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
    <a href="/JohnnyLChang/Padding-oracle-attack/pulls" class="js-selected-navigation-item reponav-item" data-hotkey="g p" data-selected-links="repo_pulls /JohnnyLChang/Padding-oracle-attack/pulls" itemprop="url">
      <svg aria-hidden="true" class="octicon octicon-git-pull-request" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M11 11.28V5c-.03-.78-.34-1.47-.94-2.06C9.46 2.35 8.78 2.03 8 2H7V0L4 3l3 3V4h1c.27.02.48.11.69.31.21.2.3.42.31.69v6.28A1.993 1.993 0 0 0 10 15a1.993 1.993 0 0 0 1-3.72zm-1 2.92c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zM4 3c0-1.11-.89-2-2-2a1.993 1.993 0 0 0-1 3.72v6.56A1.993 1.993 0 0 0 2 15a1.993 1.993 0 0 0 1-3.72V4.72c.59-.34 1-.98 1-1.72zm-.8 10c0 .66-.55 1.2-1.2 1.2-.65 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2zM2 4.2C1.34 4.2.8 3.65.8 3c0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2z"/></svg>
      <span itemprop="name">Pull requests</span>
      <span class="Counter">0</span>
      <meta itemprop="position" content="3">
</a>  </span>

    <a href="/JohnnyLChang/Padding-oracle-attack/projects" class="js-selected-navigation-item reponav-item" data-hotkey="g b" data-selected-links="repo_projects new_repo_project repo_project /JohnnyLChang/Padding-oracle-attack/projects">
      <svg aria-hidden="true" class="octicon octicon-project" height="16" version="1.1" viewBox="0 0 15 16" width="15"><path fill-rule="evenodd" d="M10 12h3V2h-3v10zm-4-2h3V2H6v8zm-4 4h3V2H2v12zm-1 1h13V1H1v14zM14 0H1a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h13a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1z"/></svg>
      Projects
      <span class="Counter" >0</span>
</a>


  <a href="/JohnnyLChang/Padding-oracle-attack/pulse" class="js-selected-navigation-item reponav-item" data-selected-links="repo_graphs repo_contributors dependency_graph pulse /JohnnyLChang/Padding-oracle-attack/pulse">
    <svg aria-hidden="true" class="octicon octicon-graph" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M16 14v1H0V0h1v14h15zM5 13H3V8h2v5zm4 0H7V3h2v10zm4 0h-2V6h2v7z"/></svg>
    Insights
</a>

</nav>


  </div>

<div class="container new-discussion-timeline experiment-repo-nav">
  <div class="repository-content">

    
  <a href="/JohnnyLChang/Padding-oracle-attack/blob/c53cdd4f4e331683b601efe38df58e16dee62118/README.md" class="d-none js-permalink-shortcut" data-hotkey="y">Permalink</a>

  <!-- blob contrib key: blob_contributors:v21:a39ee83b82624c5f0ff2c77ba366c9da -->

  <div class="file-navigation js-zeroclipboard-container">
    
<div class="select-menu branch-select-menu js-menu-container js-select-menu float-left">
  <button class=" btn btn-sm select-menu-button js-menu-target css-truncate" data-hotkey="w"
    
    type="button" aria-label="Switch branches or tags" aria-expanded="false" aria-haspopup="true">
      <i>Branch:</i>
      <span class="js-select-button css-truncate-target">master</span>
  </button>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax>

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <svg aria-label="Close" class="octicon octicon-x js-menu-close" height="16" role="img" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48z"/></svg>
        <span class="select-menu-title">Switch branches/tags</span>
      </div>

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="form-control js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" data-filter-placeholder="Filter branches/tags" class="js-select-menu-tab" role="tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" data-filter-placeholder="Find a tag…" class="js-select-menu-tab" role="tab">Tags</a>
            </li>
          </ul>
        </div>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches" role="menu">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <a class="select-menu-item js-navigation-item js-navigation-open selected"
               href="/JohnnyLChang/Padding-oracle-attack/blob/master/README.md"
               data-name="master"
               data-skip-pjax="true"
               rel="nofollow">
              <svg aria-hidden="true" class="octicon octicon-check select-menu-item-icon" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5z"/></svg>
              <span class="select-menu-item-text css-truncate-target js-select-menu-filter-text">
                master
              </span>
            </a>
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div>

    </div>
  </div>
</div>

    <div class="BtnGroup float-right">
      <a href="/JohnnyLChang/Padding-oracle-attack/find/master"
            class="js-pjax-capture-input btn btn-sm BtnGroup-item"
            data-pjax
            data-hotkey="t">
        Find file
      </a>
      <button aria-label="Copy file path to clipboard" class="js-zeroclipboard btn btn-sm BtnGroup-item tooltipped tooltipped-s" data-copied-hint="Copied!" type="button">Copy path</button>
    </div>
    <div class="breadcrumb js-zeroclipboard-target">
      <span class="repo-root js-repo-root"><span class="js-path-segment"><a href="/JohnnyLChang/Padding-oracle-attack"><span>Padding-oracle-attack</span></a></span></span><span class="separator">/</span><strong class="final-path">README.md</strong>
    </div>
  </div>


  
  <div class="commit-tease">
      <span class="float-right">
        <a class="commit-tease-sha" href="/JohnnyLChang/Padding-oracle-attack/commit/c53cdd4f4e331683b601efe38df58e16dee62118" data-pjax>
          c53cdd4
        </a>
        <relative-time datetime="2017-05-31T09:00:10Z">May 31, 2017</relative-time>
      </span>
      <div>
        <img alt="@le4ker" class="avatar" height="20" src="https://avatars0.githubusercontent.com/u/1270063?s=40&amp;v=4" width="20" />
        <a href="/le4ker" class="user-mention" rel="contributor">le4ker</a>
          <a href="/JohnnyLChang/Padding-oracle-attack/commit/c53cdd4f4e331683b601efe38df58e16dee62118" class="message" data-pjax="true" title="Update README.md (#2)

* fix typo in Readme thx @PanosSakkos">Update README.md (</a><a href="https://github.com/mpgn/Padding-oracle-attack/pull/2" class="issue-link js-issue-link" data-error-text="Failed to load issue title" data-id="232085085" data-permission-text="Issue title is private" data-url="https://github.com/mpgn/Padding-oracle-attack/issues/2">#2</a><a href="/JohnnyLChang/Padding-oracle-attack/commit/c53cdd4f4e331683b601efe38df58e16dee62118" class="message" data-pjax="true" title="Update README.md (#2)

* fix typo in Readme thx @PanosSakkos">)</a>
      </div>

    <div class="commit-tease-contributors">
      <button type="button" class="btn-link muted-link contributors-toggle" data-facebox="#blob_contributors_box">
        <strong>2</strong>
         contributors
      </button>
          <a class="avatar-link tooltipped tooltipped-s" aria-label="mpgn" href="/JohnnyLChang/Padding-oracle-attack/commits/master/README.md?author=mpgn"><img alt="@mpgn" class="avatar" height="20" src="https://avatars2.githubusercontent.com/u/5891788?s=40&amp;v=4" width="20" /> </a>
    <a class="avatar-link tooltipped tooltipped-s" aria-label="le4ker" href="/JohnnyLChang/Padding-oracle-attack/commits/master/README.md?author=le4ker"><img alt="@le4ker" class="avatar" height="20" src="https://avatars0.githubusercontent.com/u/1270063?s=40&amp;v=4" width="20" /> </a>


    </div>

    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header" data-facebox-id="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list" data-facebox-id="facebox-description">
          <li class="facebox-user-list-item">
            <img alt="@mpgn" height="24" src="https://avatars3.githubusercontent.com/u/5891788?s=48&amp;v=4" width="24" />
            <a href="/mpgn">mpgn</a>
          </li>
          <li class="facebox-user-list-item">
            <img alt="@le4ker" height="24" src="https://avatars1.githubusercontent.com/u/1270063?s=48&amp;v=4" width="24" />
            <a href="/le4ker">le4ker</a>
          </li>
      </ul>
    </div>
  </div>


  <div class="file">
    <div class="file-header">
  <div class="file-actions">

    <div class="BtnGroup">
      <a href="/JohnnyLChang/Padding-oracle-attack/raw/master/README.md" class="btn btn-sm BtnGroup-item" id="raw-url">Raw</a>
        <a href="/JohnnyLChang/Padding-oracle-attack/blame/master/README.md" class="btn btn-sm js-update-url-with-hash BtnGroup-item" data-hotkey="b">Blame</a>
      <a href="/JohnnyLChang/Padding-oracle-attack/commits/master/README.md" class="btn btn-sm BtnGroup-item" rel="nofollow">History</a>
    </div>


        <button type="button" class="btn-octicon disabled tooltipped tooltipped-nw"
          aria-label="You must be signed in to make or propose changes">
          <svg aria-hidden="true" class="octicon octicon-pencil" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M0 12v3h3l8-8-3-3-8 8zm3 2H1v-2h1v1h1v1zm10.3-9.3L12 6 9 3l1.3-1.3a.996.996 0 0 1 1.41 0l1.59 1.59c.39.39.39 1.02 0 1.41z"/></svg>
        </button>
        <button type="button" class="btn-octicon btn-octicon-danger disabled tooltipped tooltipped-nw"
          aria-label="You must be signed in to make or propose changes">
          <svg aria-hidden="true" class="octicon octicon-trashcan" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M11 2H9c0-.55-.45-1-1-1H5c-.55 0-1 .45-1 1H2c-.55 0-1 .45-1 1v1c0 .55.45 1 1 1v9c0 .55.45 1 1 1h7c.55 0 1-.45 1-1V5c.55 0 1-.45 1-1V3c0-.55-.45-1-1-1zm-1 12H3V5h1v8h1V5h1v8h1V5h1v8h1V5h1v9zm1-10H2V3h9v1z"/></svg>
        </button>
  </div>

  <div class="file-info">
      182 lines (131 sloc)
      <span class="file-info-divider"></span>
    7.36 KB
  </div>
</div>

    
  <div id="readme" class="readme blob instapaper_body">
    <article class="markdown-body entry-content" itemprop="text"><h1><a href="#padding-oracle-attack" aria-hidden="true" class="anchor" id="user-content-padding-oracle-attack"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Padding Oracle Attack</h1>
<p>An exploit for the <a href="https://en.wikipedia.org/wiki/Padding_oracle_attack" rel="nofollow">Padding Oracle Attack</a>. Tested against ASP.NET, works like a charm. The CBC  mode must use <a href="https://en.wikipedia.org/wiki/Padding_%28cryptography%29#PKCS7" rel="nofollow">PKCS7</a> for the padding block.
This is an implementation of this great article <a href="https://not.burntout.org/blog/Padding_Oracle_Attack/" rel="nofollow">Padding Oracle Attack</a>. Since the article is not very well formated and maybe unclear, I made an explanation in the readme. i advise you to read it if you want to understand the basics of the attack.
This exploit allow block size of 8 or 16 this mean it can be use even if the cipher use AES or DES. You can find instructions to launch the attack <a href="https://github.com/mpgn/Padding-Oracle-Attack#options">here</a>.</p>
<p>I also made a test file <code>test.py</code>, you don't need a target to use it :)</p>
<h2><a href="#explanation" aria-hidden="true" class="anchor" id="user-content-explanation"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Explanation</h2>
<p>I will explain in this part the cryptography behind the attack. To follow this you need to understand the <a href="https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cipher_Block_Chaining_.28CBC.29" rel="nofollow">CBC mode cipher chainning</a> or <a href="https://www.youtube.com/watch?v=0D7OwYp6ZEc." rel="nofollow">video link</a> and the operator ⊕. This attack is also a <a href="https://en.wikipedia.org/wiki/Chosen-ciphertext_attack" rel="nofollow">chosen-ciphertext attack</a>.</p>
<table>
<thead>
<tr>
<th>Encryption</th>
<th>Decryption</th>
</tr>
</thead>
<tbody>
<tr>
<td>C<sub>i</sub> = E<sub>k</sub>(P<sub>i</sub> ⊕ C<sub>i-1</sub>), and C<sub>0</sub> = IV</td>
<td>P<sub>i</sub> = D<sub>k</sub>(C<sub>i</sub>) ⊕ C<sub>i-1</sub>, and C<sub>0</sub> = IV</td>
</tr></tbody></table>
<p>In CBC mode we also need a padding in the case the length of the plaintext doesn't fill all the block. For example we can have this plaintext and the following padding if the length of the block is 8 :</p>
<p><code>S|E|C|R|E|T| |M|E|S|S|A|G|E|02|02</code></p>
<p>You can notice the length of SECRET MESSAGE is 14 so we need to fill two blocks of CBC equal 16. There are two bytes left, this is where the padding step in. You can see the two last byte 0202. Another example, if the padding had a length of 5, it will be fill with 05|05|05|05|05. Of course there is different way to fill the padding but in our case like most of the case the standard is <a href="https://en.wikipedia.org/wiki/Padding_%28cryptography%29#PKCS7" rel="nofollow">PKCS7</a> for the padding block.</p>
<p>If the padding does not match the PKCS7 standard it will produce an error. Example :</p>
<p><code>S|E|C|R|E|T| |M|E|S|S|A|G|E|03|03</code></p>
<p>When the block will be deciphered there will be a verification to check if the padding is good or not :</p>
<p><code>S|E|C|R|E|T| |M|E|S|S|A|G|E|03|03</code> =&gt; Wrong padding <br>
<code>S|E|C|R|E|T| |M|E|S|S|A|G|E|02|02</code> =&gt; Good padding</p>
<p>Now imagine we can <strong>know</strong> when we have a bad padding and a good padding (the server send an "error padding" or "404 not found" when the padding is wrong etc). We will call this our <a href="http://security.stackexchange.com/questions/10617/what-is-a-cryptographic-oracle" rel="nofollow">Oracle</a>. The answers he will give us will be :</p>
<ul>
<li>good padding</li>
<li>bad padding</li>
</ul>
<p>Now we know that, we can construct a block to retrieve one byte of the plaintext, don't forget this is a chosen-ciphertext attack.
An attacker will intercept a cipher text and retrieve byte by byte the plaintext.</p>
<ul>
<li>intercepted cipher : C<sub>0</sub> | C<sub>...</sub> | C<sub>i-1</sub> | C<sub>i</sub></li>
<li>then build a block like this :</li>
</ul>
<p>C'<sub>i-1</sub> = C<sub>i-1</sub> ⊕ 00000001 ⊕ 0000000X | C<sub>i</sub></p>
<p>Where X is a char between <code>chr(0-256)</code>.</p>
<ul>
<li>then he sends C'<sub>i-1</sub> | C<sub>i</sub> to the oracle. The oracle will decrypt like this :</li>
</ul>
<p>D<sub>k</sub>(C<sub>i</sub>) ⊕ C'<sub>i-1</sub>  <br>
= D<sub>k</sub>(C<sub>i</sub>) ⊕ C<sub>i-1</sub> ⊕ 00000001 ⊕ 0000000X <br>
= P<sub>i</sub> ⊕ 00000001 ⊕ 0000000X <br></p>
<p>Now there is two possibilities: a padding error or not :</p>
<ul>
<li>if we have a padding error :</li>
</ul>
<pre><code>If P'i ⊕ 0000000Y == abcdefg5 then:
    abcdefg0 ⊕ 00000001 = abcdefg5
</code></pre>
<p>This is a wrong padding, so we can deduce the byte Y is wrong.</p>
<ul>
<li>The oracle didn't give us a padding error and we know the byte X is good :</li>
</ul>
<pre><code>If Pi ⊕ 0000000X == abcdefg0 then:
    abcdefg0 ⊕ 00000001 = abcdefg1
</code></pre>
<hr>
<p><strong>For the second byte :</strong></p>
<p>C'<sub>i-1</sub> = C<sub>i-1</sub> ⊕ 00000022 ⊕ 000000YX | C<sub>i</sub></p>
<p>And then :</p>
<p>D<sub>k</sub>(C<sub>i</sub>) ⊕ C'<sub>i-1</sub> <br>
= D<sub>k</sub>(C<sub>i</sub>) ⊕ C<sub>i-1</sub> ⊕ 00000022 ⊕ 000000YX <br>
= P<sub>i</sub> ⊕ 00000001 ⊕ 00000YX <br></p>
<ul>
<li>The oracle didn't give us a padding error and we know the byte X is good :</li>
</ul>
<pre><code>If Pi ⊕ 000000YX == abcdef00 then:
    abcdef00 ⊕ 00000022 = abcdef22
</code></pre>
<p>etc etc for all the block. You can now launch the python script by reading the next section :)</p>
<h3><a href="#protection" aria-hidden="true" class="anchor" id="user-content-protection"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Protection</h3>
<ul>
<li>Encrypt and MAC your data : <a href="http://security.stackexchange.com/questions/38942/how-to-protect-against-padding-oracle-attacks" rel="nofollow">http://security.stackexchange.com/questions/38942/how-to-protect-against-padding-oracle-attacks</a></li>
<li>Don't give error message like "Padding error", "MAC error", "decryption failed" etc</li>
</ul>
<h2><a href="#options" aria-hidden="true" class="anchor" id="user-content-options"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Options</h2>
<p>The test file if you don't have target :</p>
<div class="highlight highlight-source-shell"><pre>python test.py -m mysecretmessage</pre></div>
<p>The exploit :</p>
<pre><code>usage: exploit.py [-h] -c CIPHER -l LENGTH_BLOCK_CIPHER --host HOST -u
                  URLTARGET --error ERROR [--cookie COOKIE]
                  [--method METHOD] [--post POST] [-v]
</code></pre>
<p>Details required options:</p>
<div class="highlight highlight-source-shell"><pre>-h <span class="pl-c1">help</span>
-c cipher chain
-l length of a block example: 8 or 16
-u UrlTarget <span class="pl-k">for</span> example: <span class="pl-k">?</span>/page=
--host hostname example: google.fr
--error Error that the orcale give you <span class="pl-k">for</span> a wrong padding
    example: with HTTP method: 200,400,500
             with DOM HTML   <span class="pl-c1">:</span> <span class="pl-s"><span class="pl-pds">"</span>&lt;h2&gt;Padding Error&lt;/h2&gt;<span class="pl-pds">"</span></span></pre></div>
<p>Optional options:</p>
<div class="highlight highlight-source-shell"><pre>--cookie Cookie parameter example: PHPSESSID=9nnvje7p90b507shfmb94d7
--method Default GET methode but can se POST etc
--post POST parameter <span class="pl-k">if</span> you need example <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span>:<span class="pl-s"><span class="pl-pds">'</span>value<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>pass<span class="pl-pds">'</span></span>:<span class="pl-s"><span class="pl-pds">'</span>value<span class="pl-pds">'</span></span></pre></div>
<p>Example:</p>
<div class="highlight highlight-source-shell"><pre>python exploit.py -c E3B3D1120F999F4CEF945BA8B9326D7C3C8A8B02178E59AF506666542AB5EF44 -l 16 --host host.com -u /index.aspx<span class="pl-k">?</span>c= -v --error <span class="pl-s"><span class="pl-pds">"</span>Padding Error<span class="pl-pds">"</span></span></pre></div>
<p><a href="https://asciinema.org/a/40222" rel="nofollow"><img src="https://camo.githubusercontent.com/9bf06b161c9e4e5caf003d86426ec7e1bc3f0e05/68747470733a2f2f61736369696e656d612e6f72672f612f34303232322e706e67" height="350" width="550" data-canonical-src="https://asciinema.org/a/40222.png" style="max-width:100%;"></a></p>
<h2><a href="#customisation" aria-hidden="true" class="anchor" id="user-content-customisation"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Customisation</h2>
<blockquote>
<p>I wan to customize the Oracle !</p>
</blockquote>
<p>Example with sockets <a href="https://gist.github.com/mpgn/fce3c3f2aaa2eeb8fac5">https://gist.github.com/mpgn/fce3c3f2aaa2eeb8fac5</a></p>
<p>No problem, find these line and do what you have to do :)</p>
<ul>
<li>Custom oracle response:</li>
</ul>
<div class="highlight highlight-source-python"><pre><span class="pl-c"><span class="pl-c">#</span>###################################</span>
<span class="pl-c"><span class="pl-c">#</span> CUSTOM YOUR RESPONSE ORACLE HERE #</span>
<span class="pl-c"><span class="pl-c">#</span>###################################</span>
<span class="pl-s"><span class="pl-pds">'''</span> the function you want change to adapte the result to your problem <span class="pl-pds">'''</span></span>
<span class="pl-k">def</span> <span class="pl-en">test_validity</span>(<span class="pl-smi">response</span>,<span class="pl-smi">error</span>):
    <span class="pl-k">try</span>:
        value <span class="pl-k">=</span> <span class="pl-c1">int</span>(error)
        <span class="pl-k">if</span> <span class="pl-c1">int</span>(response.status) <span class="pl-k">==</span> value:
            <span class="pl-k">return</span> <span class="pl-c1">1</span>
    <span class="pl-k">except</span> <span class="pl-c1">ValueError</span>:
        <span class="pl-k">pass</span>  <span class="pl-c"><span class="pl-c">#</span> it was a string, not an int.</span>

    <span class="pl-c"><span class="pl-c">#</span> oracle repsonse with data in the DOM</span>
    data <span class="pl-k">=</span> response.read()
    <span class="pl-k">if</span> data.find(error) <span class="pl-k">==</span> <span class="pl-k">-</span><span class="pl-c1">1</span>:
        <span class="pl-k">return</span> <span class="pl-c1">1</span>
    <span class="pl-k">return</span> <span class="pl-c1">0</span></pre></div>
<ul>
<li>Custom oracle call (HTTP)</li>
</ul>
<div class="highlight highlight-source-python"><pre><span class="pl-c"><span class="pl-c">#</span>###############################</span>
<span class="pl-c"><span class="pl-c">#</span> CUSTOM YOUR ORACLE HTTP HERE #</span>
<span class="pl-c"><span class="pl-c">#</span>###############################</span>
<span class="pl-k">def</span> <span class="pl-en">call_oracle</span>(<span class="pl-smi">host</span>,<span class="pl-smi">cookie</span>,<span class="pl-smi">url</span>,<span class="pl-smi">post</span>,<span class="pl-smi">method</span>,<span class="pl-smi">up_cipher</span>):
    <span class="pl-k">if</span> post:
        params <span class="pl-k">=</span> urllib.urlencode({post})
    <span class="pl-k">else</span>:
        params <span class="pl-k">=</span> urllib.urlencode({})
    headers <span class="pl-k">=</span> {<span class="pl-s"><span class="pl-pds">"</span>Content-type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>application/x-www-form-urlencoded<span class="pl-pds">"</span></span>,<span class="pl-s"><span class="pl-pds">"</span>Accept<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>text/plain<span class="pl-pds">"</span></span>, <span class="pl-s"><span class="pl-pds">'</span>Cookie<span class="pl-pds">'</span></span>: cookie}
    conn <span class="pl-k">=</span> httplib.HTTPConnection(host)
    conn.request(method, url <span class="pl-k">+</span> up_cipher, params, headers)
    response <span class="pl-k">=</span> conn.getresponse()
    <span class="pl-k">return</span> conn, response</pre></div>
</article>
  </div>

  </div>

  <button type="button" data-facebox="#jump-to-line" data-facebox-class="linejump" data-hotkey="l" class="d-none">Jump to Line</button>
  <div id="jump-to-line" style="display:none">
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="" class="js-jump-to-line-form" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
      <input class="form-control linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" aria-label="Jump to line" autofocus>
      <button type="submit" class="btn">Go</button>
</form>  </div>


  </div>
  <div class="modal-backdrop js-touch-events"></div>
</div>

    </div>
  </div>

  </div>

      
<div class="footer container-lg px-3" role="contentinfo">
  <div class="position-relative d-flex flex-justify-between py-6 mt-6 f6 text-gray border-top border-gray-light ">
    <ul class="list-style-none d-flex flex-wrap ">
      <li class="mr-3">&copy; 2018 <span title="0.10548s from unicorn-3391298341-c6j8p">GitHub</span>, Inc.</li>
        <li class="mr-3"><a href="https://github.com/site/terms" data-ga-click="Footer, go to terms, text:terms">Terms</a></li>
        <li class="mr-3"><a href="https://github.com/site/privacy" data-ga-click="Footer, go to privacy, text:privacy">Privacy</a></li>
        <li class="mr-3"><a href="https://github.com/security" data-ga-click="Footer, go to security, text:security">Security</a></li>
        <li class="mr-3"><a href="https://status.github.com/" data-ga-click="Footer, go to status, text:status">Status</a></li>
        <li><a href="https://help.github.com" data-ga-click="Footer, go to help, text:help">Help</a></li>
    </ul>

    <a href="https://github.com" aria-label="Homepage" class="footer-octicon" title="GitHub">
      <svg aria-hidden="true" class="octicon octicon-mark-github" height="24" version="1.1" viewBox="0 0 16 16" width="24"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"/></svg>
</a>
    <ul class="list-style-none d-flex flex-wrap ">
        <li class="mr-3"><a href="https://github.com/contact" data-ga-click="Footer, go to contact, text:contact">Contact GitHub</a></li>
      <li class="mr-3"><a href="https://developer.github.com" data-ga-click="Footer, go to api, text:api">API</a></li>
      <li class="mr-3"><a href="https://training.github.com" data-ga-click="Footer, go to training, text:training">Training</a></li>
      <li class="mr-3"><a href="https://shop.github.com" data-ga-click="Footer, go to shop, text:shop">Shop</a></li>
        <li class="mr-3"><a href="https://github.com/blog" data-ga-click="Footer, go to blog, text:blog">Blog</a></li>
        <li><a href="https://github.com/about" data-ga-click="Footer, go to about, text:about">About</a></li>

    </ul>
  </div>
</div>



  <div id="ajax-error-message" class="ajax-error-message flash flash-error">
    <svg aria-hidden="true" class="octicon octicon-alert" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.865 1.52c-.18-.31-.51-.5-.87-.5s-.69.19-.87.5L.275 13.5c-.18.31-.18.69 0 1 .19.31.52.5.87.5h13.7c.36 0 .69-.19.86-.5.17-.31.18-.69.01-1L8.865 1.52zM8.995 13h-2v-2h2v2zm0-3h-2V6h2v4z"/></svg>
    <button type="button" class="flash-close js-ajax-error-dismiss" aria-label="Dismiss error">
      <svg aria-hidden="true" class="octicon octicon-x" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48z"/></svg>
    </button>
    You can't perform that action at this time.
  </div>


    <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/compat-e42a8bf9c380758734e39851db04de7cbeeb2f3860efbd481c96ac12c25a6ecb.js"></script>
    <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-3907d9aad812b8c94147c88165cb4a9693c57cf99f0e8e01053fc79de7a9d911.js"></script>
    
    <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-c1b10da21f1932a4173fcfb60676e2ad32e515f7ae77563ddb658f04cd26368d.js"></script>
    
    
    
    
  <div class="js-stale-session-flash stale-session-flash flash flash-warn flash-banner d-none">
    <svg aria-hidden="true" class="octicon octicon-alert" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.865 1.52c-.18-.31-.51-.5-.87-.5s-.69.19-.87.5L.275 13.5c-.18.31-.18.69 0 1 .19.31.52.5.87.5h13.7c.36 0 .69-.19.86-.5.17-.31.18-.69.01-1L8.865 1.52zM8.995 13h-2v-2h2v2zm0-3h-2V6h2v4z"/></svg>
    <span class="signed-in-tab-flash">You signed in with another tab or window. <a href="">Reload</a> to refresh your session.</span>
    <span class="signed-out-tab-flash">You signed out in another tab or window. <a href="">Reload</a> to refresh your session.</span>
  </div>
  <div class="facebox" id="facebox" style="display:none;">
  <div class="facebox-popup">
    <div class="facebox-content" role="dialog" aria-labelledby="facebox-header" aria-describedby="facebox-description">
    </div>
    <button type="button" class="facebox-close js-facebox-close" aria-label="Close modal">
      <svg aria-hidden="true" class="octicon octicon-x" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48z"/></svg>
    </button>
  </div>
</div>


  </body>
</html>


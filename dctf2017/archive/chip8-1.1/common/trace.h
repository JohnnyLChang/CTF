/*
 * chip8 - video game interpreter
 * Copyright (C) 1990, 1998, 2012 Peter Miller
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef COMMON_TRACE_H
#define COMMON_TRACE_H

#include <common/ac/stddef.h>

#include <common/debug.h>

#ifdef DEBUG
#define trace_pretest_ \
	(							\
		(						\
			trace_pretest_result			\
		?						\
			trace_pretest_result			\
		:						\
			/* will be 0 or 1 (a boolean) */	\
			(trace_pretest_result = trace_pretest(__FILE__) | 2) \
		)						\
	&							\
		1						\
	)
#define trace_where_ trace_where(__FILE__, __LINE__)
#define trace(x) (void)(trace_pretest_ && (trace_where_, trace_printf x, 0))
#define trace_if() (trace_pretest_ && (trace_where_, 1))
#else
#define trace(x)
#define trace_if() 0
#endif

/*
 * This variable is static to each file which
 * includes the "trace.h" file.
 * Tracing is file-by-file, but need only test this once.
 * Files will fail to trace if a trace call is executed in them
 * prior to a call to trace_enable turning it on.
 */
#ifdef DEBUG
static int trace_pretest_result;
#endif

int trace_pretest(const char *file);
void trace_where(const char *file, int line);
void trace_printf(const char *, ...);
void trace_enable(const char *);
void trace_char_real(char *, char *);
void trace_char_unsigned_real(char *, unsigned char *);
void trace_int_real(char *, int *);
void trace_int_unsigned_real(char *, unsigned *);
void trace_pointer_real(char *, void *);
void trace_long_real(char *, long *);
void trace_long_unsigned_real(char *, unsigned long *);
void trace_short_real(char *, short *);
void trace_short_unsigned_real(char *, unsigned short *);
void trace_string_real(const char *, const char *);


#ifdef __STDC__
#define trace_stringize(x) #x
#else
#define trace_stringize(x) "x"
#endif

#ifdef DEBUG

#define trace_char(x)						\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_char_real(trace_stringize(x), &x), \
			0					\
		)						\
	)

#define trace_char_unsigned(x)					\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_char_unsigned_real(trace_stringize(x), &x), \
			0					\
		)						\
	)

#define trace_int(x)						\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_int_real(trace_stringize(x), &x),	\
			0					\
		)						\
	)

#define trace_int_unsigned(x)					\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_int_unsigned_real(trace_stringize(x), &x), \
			0					\
		)						\
	)

#define trace_long(x)						\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_long_real(trace_stringize(x), &x), \
			0					\
		)						\
	)

#define trace_long_unsigned(x)					\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_long_unsigned_real(trace_stringize(x), &x), \
			0					\
		)						\
	)

#define trace_pointer(x)					\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_pointer_real(trace_stringize(x), &x), \
			0					\
		)						\
	)

#define trace_short(x)						\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_short_real(trace_stringize(x), &x), \
			0					\
		)						\
	)

#define trace_short_unsigned(x)					\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_short_unsigned_real(trace_stringize(x), &x), \
			0					\
		)						\
	)

#define trace_string(x)						\
	(void)							\
	(							\
		trace_pretest_					\
	&&							\
		(						\
			trace_where_,				\
			trace_string_real(trace_stringize(x), x), \
			0					\
		)						\
	)

#else

#define trace_char(x)
#define trace_char_unsigned(x)
#define trace_int(x)
#define trace_int_unsigned(x)
#define trace_long(x)
#define trace_long_unsigned(x)
#define trace_pointer(x)
#define trace_short(x)
#define trace_short_unsigned(x)
#define trace_string(x)

#endif

#endif /* COMMON_TRACE_H */

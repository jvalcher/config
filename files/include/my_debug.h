
/*
 * Debugging macros:
 *
 *      MK      ->  << MARK-> 16, file.c >>
 *      PI(n)   ->  int_val: 15
 *      PC(c)   ->  char_val: d
 *      FC      ->  func() called
 *      FR      ->  func() returned
 *
 */

#define __FILENAME__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)
#define MK     printf("<< MARK-> %d, %s >>\n", __LINE__, __FILENAME__)  // mark location
#define PI(n)  printf(#n ": %d\n", n)                 // print int value
#define PC(c)  printf(#c ": %c\n", c)                 // print char value
#define FC     printf("%s() called\n", __func__)        // function called
#define FR     printf("%s() returned\n", __func__)       // function returned



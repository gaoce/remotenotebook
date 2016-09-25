<!--
.. title: Basic sorting in R: sort vs rank vs order
.. slug: r-order
.. author: Ce Gao
.. date: 2015-04-16 22:10 UTC
.. tags: R, tutorial, examples
.. category: 
.. link: 
.. description: 
.. type: text
-->

Sorting is a very fundamental job in programming. I'm confused with three R
functions, `sort`, `order` and `rank`. Here I give some use cases to understand 
them.

<!-- TEASER_END -->
## sort
Sort a vector or factor.

First let's generate some sample data.
```{r}
set.seed(1)

# A random vector
vec = sample(1:100, 10)
# [1] 27 37 57 89 20 86 97 62 58  6

# A factor
fac = factor(vec)
#  [1] 27 37 57 89 20 86 97 62 58 6 
# Levels: 6 20 27 37 57 58 62 86 89 97

# A vector with NAs
vec.na = c(NA, vec, NA)
#  [1] NA 27 37 57 89 20 86 97 62 58  6 NA
```

```{r}
# Sort vector
sort(vec)
#  [1]  6 20 27 37 57 58 62 86 89 97

# Sort the factor
sort(fac)
#  [1] 6  20 27 37 57 58 62 86 89 97
# Levels: 6 20 27 37 57 58 62 86 89 97

# Return the result in descresing order
sort(vec, decreasing = TRUE)
#  [1] 97 89 86 62 58 57 37 27 20  6

# By default NAs are removed
sort(vec.na)
#  [1]  6 20 27 37 57 58 62 86 89 97

# NAs are put in the end
sort(vec.na, na.last = TRUE)
#  [1]  6 20 27 37 57 58 62 86 89 97 NA NA

# NAs are put in the front
sort(vec.na, na.last = FALSE)
#  [1] NA NA  6 20 27 37 57 58 62 86 89 97

# Partial sorting
sort(vec, partial = c(5, 9))
#  [1]  6 20 27 37 57 86 58 62 89 97
```

For partial sorting, here is an illustration:
![Partial sorting]({filename}/images/sort_order_rank/r_partial_sort.png)

## rank
Return the ranks of elements in a vector.

```{r}
# Return the ranks of elements in increasing order
rank(vec)
#  [1]  3  4  5  9  2  8 10  7  6  1

# Dealing with ties, note the two ends of results
vec.tie = c(vec, 27)
#  [1] 27 37 57 89 20 86 97 62 58  6 27

# Default behavior
rank(vec.tie, ties.method = "average")
#  [1]  3.5  5.0  6.0 10.0  2.0  9.0 11.0  8.0  7.0  1.0  3.5

# Depends on the appearance order in the original vector
rank(vec.tie, ties.method = "first")
#  [1]  3  5  6 10  2  9 11  8  7  1  4
#       ^ appears first               ^ appears later

# Randomly
rank(vec.tie, ties.method = "random")
#  [1]  3  5  6 10  2  9 11  8  7  1  4

# Take the max rank
rank(vec.tie, ties.method = "max")
#  [1]  4  5  6 10  2  9 11  8  7  1  4
# Take the min rank
rank(vec.tie, ties.method = "min")
#  [1]  3  5  6 10  2  9 11  8  7  1  3
```

## order
Return the ind of elements in sorted order
```{r}
df = data.frame(a = 1:5, b = c(1, 2, 1, 2, 3))
#   a b
# 1 1 1
# 2 2 2
# 3 3 1
# 4 4 2
# 5 5 3

ind = order(df$b, df$a)
# [1] 1 3 2 4 5

df[ind,]
#   a b
# 1 1 1
# 3 3 1
# 2 2 2
# 4 4 2
# 5 5 3
```


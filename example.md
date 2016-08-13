# Example of using "R markdown" and `knitr`

Plain text written in will become the body text of the output.  Unlike with an R script, you don't put comment characters (i.e., `#` characters) in front of text -- nothing is processed by the R terminal unless it is in a code block, which we'll see below.

Wrap code to *evaluated* by R in an "R code block"


```r
head(cars)
```

```
##   speed dist
## 1     4    2
## 2     4   10
## 3     7    4
## 4     7   22
## 5     8   16
## 6     9   10
```

By default, R will print the command that you entered and below that the output with comment characters preceeding it.

# Controlling chunk evaluation / printing / etc

There are three related options for controlling what gets evaluated and printed from a code chunk.

* `results`: This can be set to `"markup"` (the default) or `"hide"` to supress output.  Note the quotes!  There is another option `"asis"` that turns out to be useful sometimes, but only when you're _generating_ Markdown with your R code.
* `echo`: When this is `TRUE` (the default), your code will be included in the output document.  When `FALSE`, your code will not be printed.
* `eval`: This is `TRUE` by default, and indicates if code should be run.  It may still be printed (based on `echo`) but the value of `results` will not matter because it won't generate any output.

This block of code will run, but leave no trace of its running in the final document:


This code will not run, but allows you to include a block of R text in the final document (with pretty syntax highlighting):

```r
f <- function(x) {
  # code would go here...
}
```

This code will run, but only show the output:

```
##           [,1]      [,2]      [,3]      [,4]       [,5]
## [1,] 0.4268997 0.1733756 0.5404275 0.3321679 0.70676884
## [2,] 0.3572063 0.8362565 0.8529195 0.1249304 0.71719361
## [3,] 0.6959281 0.3516495 0.5687528 0.4401536 0.03170159
## [4,] 0.7721216 0.2337678 0.2501445 0.2950676 0.55357555
```

This code will run, but show only the input:

```r
b <- a + 1
```

# Inserting figures

You can insert figures just like normal code blocks:

```r
plot(1:10)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png)

There are more options though: the `fig.width` and `fig.height` control the sizes:


```r
plot(1:10)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png)

Sometimes when you're making figures you'll want to hide the actual R code used to generate it; use `echo=FALSE` as above.

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png)

# A slightly more realistic example



Here is my data set

```r
head(d)
```

```
##           x        y group
## 1 0.2655087 2.100985     2
## 2 0.3721239 2.118762     2
## 3 0.5728534 3.269817     2
## 4 0.9082078 3.464871     2
## 5 0.2016819 1.512926     2
## 6 0.8983897 2.190895     2
```

Fit a simple linear model:


```r
fit <- lm(y ~ x + group, d)
```

Both of the factors are significant:

```r
anova(fit)
```

```
## Analysis of Variance Table
## 
## Response: y
##           Df Sum Sq Mean Sq F value   Pr(>F)   
## x          1  7.847  7.8471  8.9003 0.005025 **
## group      1 10.976 10.9759 12.4490 0.001137 **
## Residuals 37 32.622  0.8817                    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

The estimated slope of `y` on `x` is 1.5008804.  The full coefficient list and their errors is


```r
summary(fit)
```

```
## 
## Call:
## lm(formula = y ~ x + group, data = d)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.64967 -0.67831  0.03495  0.49993  2.11504 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)   
## (Intercept)  -0.2111     0.5333  -0.396  0.69452   
## x             1.5009     0.5370   2.795  0.00818 **
## group         1.0491     0.2973   3.528  0.00114 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.939 on 37 degrees of freedom
## Multiple R-squared:  0.3659,	Adjusted R-squared:  0.3316 
## F-statistic: 10.67 on 2 and 37 DF,  p-value: 0.0002188
```


Look at the residuals/fitted diagnostic plot:


```r
plot(fit, 1)
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14-1.png)



# Other markdown tricks

## Tables

Tables are not much fun to make.  There is a markdown mode:

Fruit | Cost
------|-----
Apple | $1.20
Pear  | $2.10

but it's fiddly to deal with.

## Links

To make a link, you put the text you want to appear within square brackets, and the target of the link in parentheses.  For example here is a link to [our website](http://nicercode.github.io).

## Images

To include an image (not one of your R figures), the code looks like `![alt text](uri)`, where `"alt text"` is the text that will be included for people who can't see the image (and the hover-over text in some browsers), and the `uri` can be a relative link to a file on your computer or a full url (i.e., begining with `http://`).  For example:

![some kittens](http://placekitten.com/g/600/200)

Using the results option to generate images

![some kittens](http://placekitten.com/g/100/100)  
![some kittens](http://placekitten.com/g/200/100)  
![some kittens](http://placekitten.com/g/300/100)  
![some kittens](http://placekitten.com/g/400/100)  
![some kittens](http://placekitten.com/g/500/100)  
![some kittens](http://placekitten.com/g/600/100)  

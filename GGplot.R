
library("tidyverse")
#install.packages("tidyverse")

#template
#   ggplot(data = <DATA>) + 
 #   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


#With ggplot2, you begin a plot with the function ggplot(). 
#ggplot() creates a coordinate system that you can add layers to. 
#The first argument of ggplot() is the dataset to use in the graph. 
#So ggplot(data = mpg) creates an empty graph
ggplot(data = mpg)


#You complete your graph by adding one or more layers to ggplot(). 
#The function geom_point() adds a layer of points to your plot, which creates a scatterplot. 
#ggplot2 comes with many geom functions that each add a different type of layer to a plot
ggplot(data = mpg)+geom_point(mapping = aes(x=displ,y=hwy))
#You can add a third variable, like class, to a two dimensional scatterplot by mapping it to an aesthetic. 
#An aesthetic is a visual property of the objects in your plot. 
#Aesthetics include things like the size, the shape, or the color of your points. 
#You can display a point (like the one below) in different ways by changing the values of its aesthetic properties. 

?geom_point
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = class, stroke = 2, shape = class<6))
#To facet your plot by a single variable, use facet_wrap(). 
#The first argument of facet_wrap() should be a formula, which you create with ~ followed by a variable name (here “formula” is the name of a data structure in R, not a synonym for “equation”). 
#The variable that you pass to facet_wrap() should be discrete.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 4)
#To facet your plot on the combination of two variables, add facet_grid() to your plot call. 
#The first argument of facet_grid() is also a formula. 
#This time the formula should contain two variable names separated by a ~.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)



#To change the geom in your plot, change the geom function that you add to ggplot(). 
#For instance, to make the plots above, you can use this
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
#With linetype broken by the drv
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

#Now plotting two different geoms on the same plot and colouring everything

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy,linetype = drv, colour = drv))+
  geom_point(mapping = aes(x = displ, y = hwy,colour = drv));


#This, however, introduces some duplication in our code. 
#Imagine if you wanted to change the y-axis to display cty instead of hwy. 
#You’d need to change the variable in two places, and you might forget to update one. 
#You can avoid this type of repetition by passing a set of mappings to ggplot(). 
#ggplot2 will treat these mappings as global mappings that apply to each geom in the graph. 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()


ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))




# aag2015
This repository contains the code, data, and slides for my talk at the 2015 AAG meetings, ["Immigration and the 'Great Inversion.'"](http://meridian.aag.org/callforpapers/program/AbstractDetail.cfm?AbstractID=63785)

To reproduce: the `slopegraphs.R` script will create the ggplot2 slopegraphs, and the `lq.R` script will create the location quotient plots, and export the data for mapping in a desktop GIS or CartoDB.  You can also push the data directly to CartoDB if you have the [kwgeo](https://github.com/walkerke/kwgeo) package installed.  

The RevealJS slide deck, produced with Slidify, is also reproducible by issuing the command `slidify::slidify('index.Rmd')`.  A second slide deck, `index2.Rmd` is also included with entirely local assets.  

I appreciate any comments or feedback!

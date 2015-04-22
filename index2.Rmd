---
title       : AAG 2015
subtitle    : August 25, 2014
author      : Kyle Walker
job         : Texas Christian University
framework   : revealjs2        # {io2012, html5slides, shower, dzslides, ...}
revealjs: 
  theme: night
  transition: none
  widescreen: yes
  center: "false"
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

# Immigration and the "Great Inversion"

### Kyle Walker
### Texas Christian University
### April 24, 2015

--- {bg: "assets/img/rings.jpg", id: chicago }

# CHICAGO

###### [Image source: CityLab](http://cdn.citylab.com/media/img/citylab/2013/08/06/87_chicago_concentric_zones_1/lead_large.jpg) 

---

## _The Great Inversion_ (Ehrenhalt, 2012)


<img src=assets/img/inversion.jpg style="width: 500px">

---

## Immigrant suburbanization in the news

.fragment 1983 

.fragment <img src=assets/img/imm1983.png>

.fragment 1993

.fragment <img src=assets/img/imm1993.png>

.fragment 2010

.fragment <img src=assets/img/imm2010.png>

--- {id: sect1}

# Inversion and regions of origin

---

<img src=plots/all.png style="width: 50%">

---

<img src=plots/latam.png style="width: 55%">

---

<img src=plots/ese.png style="width: 55%">

--- {id: sect2}

# The distance profile of immigration

---

<img src=plots/c1.png style="width: 80%">

---

<img src=plots/c2.png style="width: 80%">

---

<img src=plots/d1.png style="width: 80%">

---

<img src=plots/d2.png style="width: 80%">

--- {id: sect3}

# The geography of inversion

---

<img src=assets/img/chicago_latam.jpg style="width: 40%">

---

<img src=assets/img/chicago_ese.jpg style="width: 40%">

---

<img src=assets/img/dfw_latam.jpg style="width: 70%">

---

<img src=assets/img/dfw_ese.jpg style="width: 70%">

--- {bg: "assets/img/chinatown.jpg", id: chinatown}

## Greatest increase in E/SE Asian concentration, Chicago

###### [Image source: Wikimedia Commons](http://upload.wikimedia.org/wikipedia/commons/0/06/Chicago_Chinatown_night.jpg)

--- {bg: "assets/img/carrollton.jpg", id: carrollton}

## Greatest increase in E/SE Asian concentration, Dallas-Fort Worth

###### [Image source: Trulia](http://thumbs.trulia-cdn.com/pictures/thumbs_5/ps.72/3/3/6/1/picture-uh=f74669d7bede55d3689ead52588fa11-ps=3361454ad15bc412efb8383449ae46-3812-Branch-Hollow-Pl-Carrollton-TX-75007.jpg)

--- {id: sect4}

# Future directions

---

## Questions? 

* Slides, data, and code: https://github.com/walkerke/aag2015
* Web: http://personal.tcu.edu/kylewalker
* Email: kyle dot walker at tcu dot edu
* Twitter: [@kyle_e_walker](https://twitter.com/kyle_e_walker)




<style>

#chicago h1 {
  color: red; 
  position: absolute;
  right: 280px;
}

#chicago h6 {
  color: black;
  position: absolute;
  left: 5px; 
  bottom: -850px;
}

#chinatown h6 {
  color: black;
  position: absolute;
  right: 1200px; 
  bottom: -700px;
}

#carrollton h2 {
  color: crimson;
}

#carrollton h6 {
  position: absolute;
  right: 1200px; 
  bottom: -700px;
}

#sect1 h1 {
  position: absolute;
  bottom: -500px;
}

#sect2 h1 {
  position: absolute;
  bottom: -500px;
}

#sect3 h1 {
  position: absolute;
  bottom: -500px;
}

#sect4 h1 {
  position: absolute;
  bottom: -500px;
}


</style>













<!--

Outline: 

I. Introduce popular media treatment of issue; assumption that immigrants are increasingly suburbanizing for some time
II. Touch (briefly) on academic literature here
III. Data and methods: 
    + EDA/Viz of trends in immigrant suburbanization b/w 2000 and 2009-2013
    + EDA/ESDA for Chicago and DFW

IV. Overall trends
    + Overall slope chart (top 50 metros)
    + Small multiples slope charts for selected metros
    
V. Look at change in location quotients for Chicago and DFW
    + E/SE Asia map
    + Latin America map
    + Loess plots - are there any areas of growth near the core?  

VI: LISA analysis 
    + Plot LISA clusters - 2000 and 2013 - and assess change
    + Explore Markov chains?  
    
-->
    




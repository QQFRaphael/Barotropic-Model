; This script is used to convert GetVorticity.nc to Gaussian 
; R40 grids and make forcing field

load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

f = addfile("../data/GetVorticity.nc", "r")

div = f->div
vor = f->vor
vpt = f->vpt
str = f->str

lat = f->lat
lon = f->lon

; Gaussian R40 grids
latout = (/-88.66,-86.91,-85.16,-83.41,-81.65,-79.9,-78.14,-76.39,  \
          -74.63,-72.88,-71.12,-69.36,-67.61,-65.85,-64.1,-62.34,-60.58,-58.83, \
          -57.07,-55.32,-53.56,-51.8,-50.05,-48.29,-46.54,-44.78,-43.02,-41.27, \
          -39.51,-37.76,-36.00,-34.24,-32.49,-30.73,-28.98,-27.22,-25.46,-23.71, \
          -21.95,-20.19,-18.44,-16.68,-14.93,-13.17,-11.41,-9.66,-7.9,-6.15, \
          -4.39,-2.63,-0.88,0.88,2.63,4.39,6.15,7.9,9.66,11.41, \
          13.17,14.93,16.68,18.44,20.19,21.95,23.71,25.46,27.22,28.98, \
          30.73,32.49,34.24,36.00,37.76,39.51,41.27,43.02,44.78,46.54, \
          48.29,50.05,51.8,53.56,55.32,57.07,58.83,60.58,62.34,64.10, \
          65.85,67.61,69.36,71.12,72.88,74.63,76.39,78.14,79.9,81.65, \
          83.41,85.16,86.91,88.66/)

lonout = (/0, 2.8125, 5.625, 8.4375, 11.25, 14.0625, 16.875, 19.6875, 22.5, \
    25.3125, 28.125, 30.9375, 33.75, 36.5625, 39.375, 42.1875, 45, 47.8125, \
    50.625, 53.4375, 56.25, 59.0625, 61.875, 64.6875, 67.5, 70.3125, 73.125, \
    75.9375, 78.75, 81.5625, 84.375, 87.1875, 90, 92.8125, 95.625, 98.4375, \
    101.25, 104.0625, 106.875, 109.6875, 112.5, 115.3125, 118.125, 120.9375, \
    123.75, 126.5625, 129.375, 132.1875, 135, 137.8125, 140.625, 143.4375, \
    146.25, 149.0625, 151.875, 154.6875, 157.5, 160.3125, 163.125, 165.9375, \
    168.75, 171.5625, 174.375, 177.1875, 180, 182.8125, 185.625, 188.4375, \
    191.25, 194.0625, 196.875, 199.6875, 202.5, 205.3125, 208.125, 210.9375, \
    213.75, 216.5625, 219.375, 222.1875, 225, 227.8125, 230.625, 233.4375, \
    236.25, 239.0625, 241.875, 244.6875, 247.5, 250.3125, 253.125, 255.9375, \
    258.75, 261.5625, 264.375, 267.1875, 270, 272.8125, 275.625, 278.4375, \
    281.25, 284.0625, 286.875, 289.6875, 292.5, 295.3125, 298.125, 300.9375, \
    303.75, 306.5625, 309.375, 312.1875, 315, 317.8125, 320.625, 323.4375, \
    326.25, 329.0625, 331.875, 334.6875, 337.5, 340.3125, 343.125, 345.9375, \
    348.75, 351.5625, 354.375, 357.1875/)

div_r = linint2_Wrap(lon, lat, div, True, lonout, latout, 0)
vor_r = linint2_Wrap(lon, lat, vor, True, lonout, latout, 0)
vpt_r = linint2_Wrap(lon, lat, vpt, True, lonout, latout, 0)
str_r = linint2_Wrap(lon, lat, str, True, lonout, latout, 0)

system("rm -rf ../data/Gaussian_R40.nc")
out = addfile("../data/Gaussian_R40.nc", "c")
out->div = div_r
out->vor = vor_r
out->vpt = vpt_r
out->str = str_r
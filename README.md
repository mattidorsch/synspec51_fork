# synspec51_fork

A fork of Synspec 51, the stellar spectrum synthesis code by Ivan Hubeny & Thierry Lanz ([Hubeny & Lanz 2011](https://www.ascl.net/1109.022)). Synspec is not my work; this fork only adds small additions, mostly  treatment of ionised heavy metals, updated He I broadening tables, linear Zeeman splitting, and some minor improvements.

For a general manual on Synspec 51, see [Hubeny & Lanz (2017)](https://arxiv.org/abs/1706.01859).

### Features

#### HeI Broadening
To enable the Beauchamp HeI broadening tables, set `ihe1pr=2` in `fort.55`. The implementation is similar to that of [Bédard et al. (2020)](https://ui.adsabs.harvard.edu/abs/2020ApJ...901...93B/abstract), using the tables of [Beauchamp et al. (1997)](https://ui.adsabs.harvard.edu/abs/1997ApJS..108..559B/abstract),  [Gianninas et al. (2009)](https://ui.adsabs.harvard.edu/abs/2009A%26A...503..293G/abstract), and [Lara et al. (2012)](https://ui.adsabs.harvard.edu/abs/2012A%26A...542A..75L/abstract). Also provided are tables from [Tremblay et al. (2026)](https://ui.adsabs.harvard.edu/abs/2026ApJ..1000..253T/abstract) in the same format. 

#### Heavy Metals
Treatment of heavy metals (Z>30) is extended to ionsiation stages higher than III, typically up to VII; see [Dorsch et al. (2019)](https://ui.adsabs.harvard.edu/abs/2019A%26A...630A.130D/abstract) for details. See `AAREADME_linelist.txt` for a poorly formatted summary.  

#### Updated line list
The updated line list is based on the 2017 Kurucz line list, but includes many more transitions for ionised heavy metals. Some references are described by [Dorsch et al. (2019)](https://ui.adsabs.harvard.edu/abs/2019A%26A...630A.130D/abstract), further updated by Dorsch et al. (2026, submitted). 

#### Linear Zeeman Splitting
To enable linear Zeeman splitting ([Dorsch et al. 2022](https://ui.adsabs.harvard.edu/abs/2022A%26A...658L...9D/abstract)), set `imode=3` in `fort.55`, followed by two numbers on a new line:
- `bfield` — magnetic field strength in kG
- `bangle` — angle between field and line of sight in degrees (10 to 90)

Note that the `DATA` folder was renamed to `data` for and an additional `data_syn` folder was added. The latter contains data necessary to compute the partition functions for heavy metals, the updated He I broadening tables, and atomic data for Zeeman splitting.

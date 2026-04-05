# synspec51_fork

A fork of Synspec 51, the stellar spectrum synthesis code by Ivan Hubeny & Thierry Lanz ([Hubeny & Lanz 2011](https://www.ascl.net/1109.022)). Synspec is not my work; this fork only adds small additions, mostly  treatment of ionised heavy metals, updated He I broadening tables, linear Zeeman splitting, and some minor improvements.

For a general manual on Synspec 51, see [Hubeny & Lanz (2017)](https://arxiv.org/abs/1706.01859).

### Features

#### HeI Broadening
To enable the Beauchamp HeI broadening tables, set `ihe1pr=2` in `fort.55`. The implementation is similar to that of [Bédard et al. (2020)](https://ui.adsabs.harvard.edu/abs/2020ApJ...901...93B/abstract), using the tables of [Beauchamp et al. (1997)](https://ui.adsabs.harvard.edu/abs/1997ApJS..108..559B/abstract),  [Gianninas et al. (2009)](https://ui.adsabs.harvard.edu/abs/2009A%26A...503..293G/abstract), and [Lara et al. (2012)](https://ui.adsabs.harvard.edu/abs/2012A%26A...542A..75L/abstract). Also provided are tables from [Tremblay et al. (2026)](https://ui.adsabs.harvard.edu/abs/2026ApJ..1000..253T/abstract) in the same format. Tables:

- `data_syn/beachamp_irrgang.dat`: This is a fixed version of the Beauchamp+ 1997 tables, excluding poorly normalised tables. For He I 4471, data from Gigosos+ (2009) is used, and data from Lara+ (2012) for 4922. This fixed table was constructed by Andreas Irrgang and Matti Dorsch, in collaboration with Antoine Bédarad. Cite Bédard et al. (2020), Lara et al. (2012), Gianninas et al. (2009), and Beauchamp et al. (1997). 
- `data_syn/Tremblay26_format.dat`: Tables from Tremblay et al. (2026) in the Beauchamp+ 1997 format. Cite Tremblay et al. (2026). 
- `data_syn/Beachamp25_LD_format.dat`: Tables from Tremblay et al. (2026) in the Beauchamp+ 1997 format, but using only the recomputed Beachamp tables. Cite Tremblay et al. (2026). 

#### Heavy Metals
Treatment of heavy metals (Z>30) is extended to ionsiation stages higher than III, typically up to VII; see [Dorsch et al. (2019)](https://ui.adsabs.harvard.edu/abs/2019A%26A...630A.130D/abstract) for details. In short, partition functions are computed in a modified version of <tt>PFSPEC</tt>. Existing energy level information was extracted from the source code and is now stored in the external file <tt>data_syn/pfspec_data.dat</tt>. Energy levels for new ions are taken mostly from [NIST](https://physics.nist.gov/PhysRefData/ASD/levels_form.html), or from individual papers. 

#### Updated line list
The updated line list `data_syn/linelist.dat.gz` is based on R. Kurucz's line list ([Kurucz 2018](https://ui.adsabs.harvard.edu/abs/2018ASPC..515...47K/abstract)) `gfall08oct17.dat`, as available on [Kurucz's website](http://kurucz.harvard.edu/linelists/gfnew/gfall08oct17.dat). 
The list provided here includes many more transitions for ionised heavy metals, as well as updated line positions mostly for lines seen in UV and optical spectra of He-sdO stars. Some references are described by [Dorsch et al. (2019)](https://ui.adsabs.harvard.edu/abs/2019A%26A...630A.130D/abstract), further updated by Dorsch et al. (2026, submitted). See `AAREADME_linelist.txt` for a poorly formatted summary.  

#### Linear Zeeman Splitting
To enable linear Zeeman splitting ([Dorsch et al. 2022](https://ui.adsabs.harvard.edu/abs/2022A%26A...658L...9D/abstract)), set `imode=3` in `fort.55`, followed by two numbers on a new line:
- `bfield` — magnetic field strength in kG
- `bangle` — angle between field and line of sight in degrees (10 to 90)

Zeeman splitting requires knowledge of the L, S quantum numbers for the lower and upper energy level. This is currently implemented by matching the level energy for a specific ion and using data stored in `data_syn/zeeman_data.dat`. In principle it would be better to have this information directly in the line list. 

Note that the `DATA` folder was renamed to `data` for and an additional `data_syn` folder was added. The latter contains data necessary to compute the partition functions for heavy metals, the updated He I broadening tables, and atomic data for Zeeman splitting.

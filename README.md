## synspec51_fork

A fork of Synspec 51, the stellar spectrum synthesis code by Ivan Hubeny & Thierry Lanz ([Hubeny & Lanz 2011](https://www.ascl.net/1109.022)). Synspec is not my work; this fork only includes small additions, mostly treatment of ionised heavy metals, updated He I broadening tables, linear Zeeman splitting, and some minor improvements and bug fixes.

For a general manual on Synspec 51, see [Hubeny & Lanz (2017)](https://arxiv.org/abs/1706.01859).

### Features

#### He I broadening
The implementation is similar to that of [Bédard et al. (2020)](https://ui.adsabs.harvard.edu/abs/2020ApJ...901...93B/abstract), using the tables of [Beauchamp et al. (1997)](https://ui.adsabs.harvard.edu/abs/1997ApJS..108..559B/abstract),  [Gianninas et al. (2009)](https://ui.adsabs.harvard.edu/abs/2009A%26A...503..293G/abstract), and [Lara et al. (2012)](https://ui.adsabs.harvard.edu/abs/2012A%26A...542A..75L/abstract). Also provided are tables from [Tremblay et al. (2026)](https://ui.adsabs.harvard.edu/abs/2026ApJ..1000..253T/abstract) in the same format. Tables:

- `data_syn/beachamp_irrgang.dat`: This is a fixed version of the Beauchamp+ 1997 tables, excluding poorly normalised tables. For He I 4471, data from Gigosos+ (2009) is used, and data from Lara+ (2012) for 4922. This fixed table was constructed by Andreas Irrgang and Matti Dorsch, in collaboration with Antoine Bédarad. Cite Bédard et al. (2020), Lara et al. (2012), Gianninas et al. (2009), and Beauchamp et al. (1997). 
- `data_syn/Tremblay26_format.dat`: Tables from Tremblay et al. (2026) in the Beauchamp+ 1997 format. Cite Tremblay et al. (2026). 
- `data_syn/Beachamp25_LD_format.dat`: Tables from Tremblay et al. (2026) in the Beauchamp+ 1997 format, but using only the recomputed Beachamp tables. Cite Tremblay et al. (2026).

If `ihe1pr=2` is set in `fort.55`, the table stored in `data_syn/beachamp_irrgang.dat` will be used.

#### Heavy-metal ionization data

Support for heavy metals (`Z > 30`) has been extended to ionisation stages beyond III, typically up to VII. See [Dorsch et al. (2019)](https://ui.adsabs.harvard.edu/abs/2019A%26A...630A.130D/abstract) for the basic implementation and initial atomic data sources. A major extension of the line list is described in [Dorsch et al. (2026)](https://ui.adsabs.harvard.edu/abs/2026A%26A...711A..63D/abstract). 

In summary:

* Partition functions are computed using a modified version of `PFSPEC`, using `PARTDV`. 
* Existing energy-level data were extracted from the original synspec51 source code and moved to the external file `data_syn/pfspec_data.dat`.
* Energy levels for newly added ions are primarily sourced from NIST ([Atomic Spectra Database](https://physics.nist.gov/PhysRefData/ASD/levels_form.html)) or, where necessary, from individual publications.

The file `data_syn/pfspec_data.dat` is read by the `pfspec_data_storage` module.

For each ion, the file contains:

1. A header line:
   ```text
   ELEMENT ION_STAGE NLEVELS IONIZATION_POTENTIAL ATOMIC_NUMBER
   ```
   * `ELEMENT` - chemical element symbol
   * `ION_STAGE` - ionisation stage
   * `NLEVELS` - number of energy levels listed for the ion
   * `IONIZATION_POTENTIAL` - ionisation potential in **eV**
   * `ATOMIC_NUMBER` - atomic number of the element

2. Followed by `NLEVELS` entries of the form:
   ```text
   N G EN S
   ```
   * `N` - principal quantum number
   * `G` - statistical weight
   * `EN` - excitation energy in **eV**
   * `S` - screening constant

This structure allows new ions and energy levels to be added without modifying the source code, aside from enabling the corresponding ions in the standard subroutine `STATE0`.

#### Updated line list
The updated line list `data_syn/linelist.dat.gz` is based on R. Kurucz's line list ([Kurucz 2018](https://ui.adsabs.harvard.edu/abs/2018ASPC..515...47K/abstract)) `gfall08oct17.dat`, as available on [Kurucz's website](http://kurucz.harvard.edu/linelists/gfnew/gfall08oct17.dat). 
The list provided here includes many more transitions for ionised heavy metals, as well as updated line positions mostly for lines seen in UV and optical spectra of He-sdO/B stars. Some references are described by [Dorsch et al. (2019)](https://ui.adsabs.harvard.edu/abs/2019A%26A...630A.130D/abstract); the list was significantly extended by [Dorsch et al. (2026)](https://ui.adsabs.harvard.edu/abs/2026A%26A...711A..63D/abstract). See `AAREADME_linelist.txt` for a poorly formatted summary.  

#### Linear Zeeman splitting
To enable linear Zeeman splitting ([Dorsch et al. 2022](https://ui.adsabs.harvard.edu/abs/2022A%26A...658L...9D/abstract)), set `imode=3` in `fort.55`, followed by two numbers on a new line:
- `bfield` - magnetic field strength in kG
- `bangle` - angle between field and line of sight in degrees (10 to 90)

Zeeman splitting requires knowledge of the L, S quantum numbers for the lower and upper energy level. This is currently implemented by matching the level energy for a specific ion and using data stored in `data_syn/zeeman_data.dat`. In principle it would be better to have this information directly in the line list. 

Note that the `DATA` folder was renamed to `data` for and an additional `data_syn` folder was added. The latter contains data necessary to compute the partition functions for heavy metals, the updated He I broadening tables, and atomic data for Zeeman splitting.

#### Wind mode
Synspec includes a wind mode that solves the transfer equation in the observer's frame along impact-parameter rays through a spherically expanding envelope, producing asymmetric (blue-shifted) line profiles. It was used by [Lanz et al. (1997)](https://ui.adsabs.harvard.edu/abs/1997ApJ...485..843L/abstract) to measure the weak wind of BD+75 325. The only changes here are small fixes, like the frequency handling (opacity table padded by +-vinf/c).

Enable it by subtracting 100 from `imode` (e.g. `imode=-100` for a normal spectrum) and appending two records at the end of `fort.55`:
```text
velmax itrad nltoff iemoff
rstar rmax amloss vinf beta ndrad nrcore nfiry ndf nda [dclmax vclm]
```
- `velmax` - velocity (km/s) above which LTE background lines are rejected; if negative, the structure is instead read from the end of `fort.8` (`SETWIN` path: per-depth `r, v, vturb, denscon`)
- `itrad` - 1: excitation/ionization of the LTE background from radiation temperatures ([Schmutz 1991](https://ui.adsabs.harvard.edu/abs/1991sabc.conf..191S/abstract)); 0: strict LTE
- `nltoff`, `iemoff` - also reject NLTE lines / only line emissivity above `velmax` (normally 0 0)
- `rstar` - photospheric radius in R⊙, anchored at r(T=Teff), i.e. the SED-fit radius
- `rmax` - outer boundary in units of `rstar`
- `amloss`, `vinf`, `beta` - mass-loss rate (M⊙/yr) and β-law parameters v = v∞(1−r₀/r)^β; the velocity follows the continuity equation v = Ṁ/4πr²ρ in the hydrostatic part and transitions smoothly to the β law
- `ndrad` - total radial layers (model ND + added wind layers); `nrcore` - core rays; `nfiry` - outermost rays with a velocity-resolved fine grid; `ndf` - fine density grid for the opacity table (0 = ndrad); `nda` - diagnostic print only
- `dclmax`, `vclm` (optional) - clumping law D(v) = 1 + (D_max−1)·exp(−v_cl/v), density contrast D = 1/f_vol; omit for a smooth wind

Typical sdO settings (following [Krticka et al. 2016](https://ui.adsabs.harvard.edu/abs/2016A%26A...593A.101K/abstract), Mdot = 1e-12 - 1e-9 Msun / yr, vinf = 500 - 1800 km/s depending on radius and Teff):
```text
300. 1 0 0
0.2 1.2 1e-10 1000. 1.0 90 20 10 0 0
```
with `ndrad` = model ND + 20. For most sdO/Bs, winds are not detectable (Mdot < 1e-12) and the wind mode is not needed. Also, at low mass-loss rates the profiles are insensitive to `vinf`.

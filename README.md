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

Enable it by subtracting 100 from `imode` (e.g. `imode=-100` for a normal spectrum) and appending to the end of `fort.55`:
```text
velmax itrad nltoff iemoff
rstar rmax amloss vinf beta ndrad nrcore nfiry ndf nda
CLUMP  dclmax [vclm]
WTEMP  twind
NEB    iwneb [vtwind [vblnd]]
VLAW   vplat [rplat [bspan]]
SHIELD fshld [fcov]
COVER  fpcov
TILT   qtilt [vtilt [iatilt iztilt [vtcut]]]
COMP   v0 b fcov nion (Z stage log(N/g)) x nion [Texc]
END
```
Only the first two records are required. Every keyword line may be omitted (its parameters keep their defaults) or given in any order, and trailing values within a line may be dropped. Keywords are case-insensitive; blank lines and lines starting with `!`, `*` or `#` are skipped; `END` stops early. A line that is neither a keyword nor a `COMP` record is reported and skipped.

The legacy positional form is still accepted, everything on the second record:
```text
rstar rmax amloss vinf beta ndrad nrcore nfiry ndf nda [dclmax vclm [twind [iwneb [vtwind vblnd [vplat rplat [fcov [fshld [bspan [qtilt vtilt iatilt iztilt [vtcut [fpcov]]]]]]]]]]]
```
optionally followed by an untagged `COMP` record.

- `velmax` - velocity (km/s) above which LTE background lines are rejected; if negative, the structure is instead read from the end of `fort.8` (`SETWIN` path: per-depth `r, v, vturb, denscon`)
- `itrad` - 1: excitation/ionization of the LTE background from radiation temperatures ([Schmutz 1991](https://ui.adsabs.harvard.edu/abs/1991sabc.conf..191S/abstract)); 0: strict LTE
- `nltoff`, `iemoff` - also reject NLTE lines / only line emissivity above `velmax` (normally 0 0)
- `rstar` - photospheric radius in solar radii, anchored at `r(T=Teff)`, i.e. the SED-fit radius
- `rmax` - outer boundary in units of `rstar`
- `amloss`, `vinf`, `beta` - mass-loss rate (Msun/yr) and beta-law parameters `v = vinf*(1-r0/r)**beta`; the velocity follows the continuity equation `v = Mdot/(4 pi r**2 rho)` in the hydrostatic part and transitions smoothly to the beta law
- `ndrad` - total radial layers (model ND + added wind layers); `nrcore` - core rays; `nfiry` - outermost rays with a velocity-resolved fine grid; `ndf` - fine density grid for the opacity table (0 = ndrad); `nda` - diagnostic print only
- `dclmax`, `vclm` (optional) - clumping law `D(v) = 1 + (dclmax-1)*exp(-vclm/v)`, density contrast `D = 1/f_vol`; omit for a smooth wind
- `twind` (optional) - if > 0, the added wind layers get the diluted radiative-equilibrium temperature `T = T_s * Wn^(1/4)` (`Wn` = geometric dilution, `T_s` = outermost model temperature), floored at `twind*T_s` (typical 0.4), and the NLTE line source function in those layers is diluted by `Wn` (normalized to 1 at the graft; hydrostatic layers keep their solved NLTE state). Omit or 0 for an isothermal, undiluted wind. Recommended for `rmax` > a few: the isothermal wind is too hot far out and overestimates the P Cygni emission humps
- `iwneb` (optional) - wind NLTE mode. In the added wind layers, (a) the ionization balance is recomputed per layer (element totals preserved), and (b) NLTE lines get a two-level scattering source function `S = (1-eps)*J_cont + eps*B(T)` with the continuum mean intensity from the scattering transfer solution and Kastner's collisional `eps`. Prevents saturated black troughs and removes excess low-velocity absorption of the dominant ion stage; recommended together with `twind`; quantitative work should still use PoWR/CMFGEN/FASTWIND instead. Values:
  - `1` - absolute nebular balance, `n(k+1)/n(k) = W*Gamma_k/(ne*alpha_k)`: photoionization rates `Gamma_k` from the TLUSTY SED (**requires `fort.13.tlusty`**, the TLUSTY unit-13 spectrum `freq[Hz] H_nu`, in the run directory) and RR+DR recombination fits from `data_syn/wind_recomb.dat` (Badnell RR + Shull & Van Steenberg 1982 DR).
  - `2` - as 1, but ions missing from `wind_recomb.dat` use hydrogenic Seaton recombination instead of stopping.
  - `3` - differential scaling, no SED or atomic data needed: stage ratios scaled by `q = (W/W_s)*(ne_s/ne)*(T/T_s)^0.8` relative to the graft layer `s`.
- `vtwind` (optional) - if > 0, wind microturbulence: `v_turb = max(vtb, vtwind*v(r))` in the added layers (typical 0.1); hydrostatic layers keep `vtb`
- `vblnd` (optional) - velocity scale (km/s) of the sonic blend between frozen model ionization and the nebular balance (default 10)
- `vplat`, `rplat` (optional) - slow dense base zone: the velocity rises only slowly to `vplat` (km/s) out to `rplat` (units of `rstar`) before the beta-law starts; density from continuity is correspondingly enhanced there. Produces broad low-velocity absorption cores of wind lines (a "filled-in" transition zone); `vplat=0` disables
- `fcov` (optional) - partial-coverage fudge: rescales the wind NLTE line opacity as if only a fraction `fcov` of the stellar disk were covered (picket fence). Weakens saturated lines but also guts unsaturated ones; `fshld` is usually the better dial (default 1 = off)
- `fshld` (optional) - multiplies the self-shielding optical depth of the two-level source function, `S = (1-eps)*K2(fshld*tau)*J_cont + eps*B`: values < 1 mean a leaky slow zone, giving weak red-wing P Cygni emission and partial filling of photospheric resonance cores (typical 0.1; default 1)
- `bspan` (optional) - span of the C1 Hermite bridge between the base/plateau and the pure beta-law, in units of the local slope length (default 4). With a plateau, a large `bspan` makes the bridge (not the beta-law) control the mid-velocity structure and `beta` has little effect; `bspan` = 0.3-1 hands the velocity range above the plateau to the beta-law. Smaller `bspan` puts more column at high velocity (deeper absorption near the terminal-velocity edge)
- `TILT` (optional) - empirical ionization tilt: the weight of stage `iztilt` of element `iatilt` (both spectroscopic, 1 = neutral) is multiplied by `(v/vtilt)**qtilt` before the stage weights are renormalized, so the element total is preserved. `qtilt` < 0 concentrates the ion at low velocity and depletes it in the outer envelope - more absorption along the line of sight, less scattered emission from the extended wind. `vtcut` > 0 turns the monotonic tilt into a peak at `vtcut`. Photospheric layers are untouched (default `qtilt` = 0 = off)
- `COVER` (optional) - flux-level partial coverage, `F = (1-fpcov)*F_phot + fpcov*F_windabs + F_windemis`: a fraction `1-fpcov` of the disk is seen without wind absorption, so saturated troughs floor at `1-fpcov` while the envelope emission is untouched. Unlike `fcov` this does not rescale opacity, so unsaturated lines are unaffected (default 1 = full coverage)
- `COMP` (optional) - discrete absorbing component in front of the wind: a structure at velocity `v0` with Doppler parameter `b` (km/s) covering a fraction `fcov` of the disk. One ground-term column `log(N/g)` (cm^-2) per ion fixes the optical depth in every line of that ion, so doublet ratios are not free parameters. No emission is added (a small covering fraction subtends a small solid angle). The optional trailing `Texc` (K) populates every line of the ion by a Boltzmann factor; absent or <= 0 means a cold absorber and only ground-term lines are included. Use for DAC/CIR-like features that no beta-law can produce

Typical luminous sdO settings (following [Krticka et al. 2016](https://ui.adsabs.harvard.edu/abs/2016A%26A...593A.101K/abstract), Mdot = 1e-12 - 1e-9 Msun / yr, vinf = 500 - 1800 km/s depending on radius and Teff):
```text
300. 1 0 0
0.2 1.2 1e-10 1000. 1.0 90 20 10 0 0
```
with `ndrad` = model ND + 20. For most sdO/Bs, winds are not detectable (Mdot < 1e-12) and the wind mode is not needed. Also, at low mass-loss rates the profiles are insensitive to `vinf`.

Example model for a luminous He-sdO (Teff = 55 kK, log g = 4.85, R = 0.7 Rsun; fitted to STIS N V/C IV wind lines, needs `fort.13.tlusty`):
```text
1300. 1 0 0
0.70 25.00 1.3e-11 1550. 1.2 380 40 100 0 0
CLUMP  10. 100.
WTEMP  0.4
NEB    1 0.1 10.
VLAW   0. 0. 1.0
SHIELD 1.0 1.0
COVER  0.85
TILT   -0.9 1000. 6 4 0.
COMP   -1454. 149. 1.0 2  7 5 14.301  6 4 13.559
END
```
i.e. clumped (D = 10), diluted wind temperature, absolute nebular balance, wind microturbulence 0.1 v, a pure beta-law from the hydrostatic seam (no plateau), 85% disk coverage, C IV concentrated toward low velocity, and a discrete absorber at -1454 km/s. One block serves both windows: the tilt is per element.

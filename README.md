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

#### Depth-dependent turbulent velocity

`VTURB` may be placed on the line immediately after the `vtb` record (line 8), in static as well as wind runs:
```text
VTURB  vt_top [vt_deep [logm0 [dlogm]]]
```
It replaces the depth-independent `vtb` by
`v(m) = vt_deep + (vt_top - vt_deep) * 0.5 * [1 - tanh((log10 m - logm0)/dlogm)]`,
so `v -> vt_top` high in the atmosphere (small column mass `m` in g/cm2) and `-> vt_deep` deep down. Defaults: `vt_deep = |vtb|`, `logm0 = -3`, `dlogm = 1`. Omit the line for the usual uniform `vtb`.

[Lanz, Hubeny & Heap (1997)](https://ui.adsabs.harvard.edu/abs/1997ApJ...485..843L/abstract) inferred ~10 km/s from the iron lines of BD+75 325 and 15-20 km/s from its N V resonance lines. A height-dependent law does not reproduce that split for this star: N V improves only in proportion to the degradation of regions the model otherwise fits well.

#### Full-range frequency grid

Frequency points are placed only around selected lines, and `INILIN` then shrinks `alam0`/`alast` to their span, so an interval with no line above the strength cut returns two points of `Infinity`/`NaN` instead of a spectrum. The optional keyword `FULLRANGE [gap]`, on the line after `vtb` (or after a `VTURB` line), covers the requested interval regardless, filling line-free stretches at `gap` times the fort.55 `space` (default 1). Without it the original code path is taken, bit-identical on `fort.7`/`12`/`16`/`17` over 1140-4000 A.

```text
1140 8800 100 10 1d-06 0.007 ! alam0 alast cutof0 cutofs relop space
0 0 ! nmlist dummy
0.74 ! vtb
FULLRANGE
```

#### Line strengths against the local background

The `fort.12` strength `STR0` and its equivalent width are divided by `ABSTD`, the continuum at the interval edges, which omits H and He II line opacity because `OPAC` adds those only from the third frequency on. Metal lines inside a Stark wing are then far too strong, by orders of magnitude in the Lyman and He II line cores.

`OPAC` accumulates metal and molecular line opacity separately and stores `ABKG = total - metal lines`; `IDTAB` divides by it at the line centre, falling back to `ABSTD` where it is not larger. `ABKG` never held the metal lines, so it contains neither the line nor its blends and nothing is subtracted back out.

Only `fort.12` changes; `ABSTD` keeps its other role as the `AVAB` selection threshold, so `fort.7` and `fort.17` are unaffected. `STR0` can only decrease. Widths follow except across `STR0 = 1.2`, where synspec's two curve-of-growth branches disagree by a factor 2.45 (1.045 against 0.427, exact 0.728), so a line crossing it widens. That discontinuity is untouched.

#### Wind mode

Synspec includes a wind mode that solves the transfer equation in the observer's frame along impact-parameter rays through a spherically expanding envelope, producing asymmetric (blue-shifted) line profiles. It was introduced by [Lanz et al. (1997)](https://ui.adsabs.harvard.edu/abs/1997ApJ...485..843L/abstract) to measure the weak wind of BD+75 325, where the wind was described simply by imposing a velocity field from the continuity equation on the hydrostatic photospheric structure.

This fork keeps that transfer scheme and adds: a beta-law envelope grafted onto the hydrostatic structure, microclumping (`CLUMP`), a diluted wind temperature (`WTEMP`), a wind NLTE mode with a nebular ionization balance and a two-level scattering source function with escape-probability damping (`NEB`, `SHIELD`), flux-level partial coverage (`COVER`), an empirical ionization tilt (`TILT`), per-ion scaling of the photoionization rates (`GAMMA`), a discrete absorbing component (`COMP`), blue-shadows-red coupling within a doublet, and an ionization-stratification table on `fort.6`. Fixes include the frequency handling (opacity table padded by +-vinf/c) and the line-centre indexing in the wind layers.

These are parameterised treatments, suitable for estimating a mass-loss rate, terminal velocity or ionization structure from a few resonance lines. Quantitative wind work should use PoWR, CMFGEN or FASTWIND.

Enable it by subtracting 100 from `imode` (e.g. `imode=-100` for a normal spectrum) and appending to the end of `fort.55`:
```text
velmax itrad nltoff iemoff
rstar rmax amloss vinf beta ndrad
CLUMP  dclmax [vclm [dfloor]]
WTEMP  twind
NEB    iwneb [vtwind [vblnd]]
VLAW   vplat [rplat [bspan]]
SHIELD fshld [fcov]
COVER  fpcov
TILT   qtilt [vtilt [iatilt iztilt [vtcut]]]
GAMMA  Z stage factor
COMP   v0 b fcov nion (Z stage log(N/g)) x nion [Texc]
END
```
Only the first two records are required, and the second holds nothing beyond `ndrad`. Every keyword line may be omitted (its parameters keep their defaults) or given in any order, and trailing values within a line may be dropped. Keywords are case-insensitive; blank lines and lines starting with `!`, `*` or `#` are skipped; `END` stops early. A line that is not a keyword is reported and skipped, as are extra values on the geometry record.

- `velmax` - velocity (km/s) above which LTE background lines are rejected; if negative, the structure is instead read from the end of `fort.8` (`SETWIN` path: per-depth `r, v, vturb, denscon`)
- `itrad` - 1: excitation/ionization of the LTE background from radiation temperatures ([Schmutz 1991](https://ui.adsabs.harvard.edu/abs/1991sabc.conf..191S/abstract)); 0: strict LTE
- `nltoff`, `iemoff` - also reject NLTE lines / only line emissivity above `velmax` (normally 0 0)
- `rstar` - photospheric radius in solar radii, anchored at `r(T=Teff)`, i.e. the SED-fit radius
- `rmax` - outer boundary in units of `rstar`
- `amloss`, `vinf`, `beta` - mass-loss rate (Msun/yr) and beta-law parameters `v = vinf*(1-r0/r)**beta`; the velocity follows the continuity equation `v = Mdot/(4 pi r**2 rho)` in the hydrostatic part and transitions smoothly to the beta law
- `ndrad` - total radial layers (model ND + added wind layers). This is the only resolution parameter: the number of core rays, the velocity-resolved fine grid along the tangent rays, and the depth grid of the opacity table are fixed at converged values
- `dclmax`, `vclm`, `dfloor` (optional) - clumping, density contrast `D = 1/f_vol`; omit for a smooth wind. Two forms, selected by the sign of `vclm`:
  - `vclm > 0`: `D(v) = 1 + (dclmax-1)*exp(-vclm/v)` - clumping switches on above `vclm` and rises outward to `dclmax`. `vclm = 0` gives a depth-independent `D = dclmax`
  - `vclm < 0`: `D(v) = dfloor + (dclmax-dfloor)*exp(-(v-v_graft)/|vclm|)` - clumping peaks at the beta-law graft and decays outward on the scale `|vclm|` to `dfloor` (default 1). Confined to the added wind layers: unlike the `vclm > 0` form it does not vanish as `v -> 0`, so it would otherwise clump the hydrostatic photosphere. This form matters because recombination scales with the in-clump electron density, so a base-peaked `D` keeps trace ions (C IV, C III) alive in the slow wind while barely touching a dominant stage like N V
- `twind` (optional) - if > 0, the added wind layers get the diluted radiative-equilibrium temperature `T = T_s * Wn^(1/4)` (`Wn` = geometric dilution, `T_s` = outermost model temperature), floored at `twind*T_s` (typical 0.4), and the NLTE line source function in those layers is diluted by `Wn` (normalized to 1 at the graft; hydrostatic layers keep their solved NLTE state). Omit or 0 for an isothermal, undiluted wind. Recommended for `rmax` > a few: the isothermal wind is too hot far out and overestimates the P Cygni emission humps
- `iwneb` (optional) - wind NLTE mode. In the added wind layers, (a) the ionization balance is recomputed per layer (element totals preserved), and (b) NLTE lines get a two-level scattering source function `S = (1-eps)*J_cont + eps*B(T)` with the continuum mean intensity from the scattering transfer solution and Kastner's collisional `eps`. Prevents saturated black troughs and removes excess low-velocity absorption of the dominant ion stage; recommended together with `twind`; quantitative work should still use PoWR/CMFGEN/FASTWIND instead. Values:
  - `1` - absolute nebular balance, `n(k+1)/n(k) = W*Gamma_k/(ne*alpha_k)`: photoionization rates `Gamma_k` from the TLUSTY SED (**requires `fort.13.tlusty`**, the TLUSTY unit-13 spectrum `freq[Hz] H_nu`, in the run directory) and RR+DR recombination fits from `data_syn/wind_recomb.dat`: radiative rates from [Badnell (2006)](https://ui.adsabs.harvard.edu/abs/2006ApJS..167..334B/abstract), dielectronic rates from [Shull & Van Steenberg (1982)](https://ui.adsabs.harvard.edu/abs/1982ApJS...48...95S/abstract), Table 2.
  - `2` - as 1, but ions missing from `wind_recomb.dat` use the hydrogenic [Seaton (1959)](https://ui.adsabs.harvard.edu/abs/1959MNRAS.119...81S/abstract) formula instead of stopping.
  - `3` - differential scaling, no SED or atomic data needed: stage ratios scaled by `q = (W/W_s)*(ne_s/ne)*(T/T_s)^0.8` relative to the graft layer `s`.
- `vtwind` (optional) - if > 0, wind microturbulence: `v_turb = max(vtb, vtwind*v(r))` in the added layers (typical 0.1); hydrostatic layers keep `vtb`
- `vblnd` (optional) - velocity scale (km/s) of the sonic blend between frozen model ionization and the nebular balance (default 10)
- `vplat`, `rplat` (optional) - slow dense base zone: the velocity rises only slowly to `vplat` (km/s) out to `rplat` (units of `rstar`) before the beta-law starts; density from continuity is correspondingly enhanced there. Produces broad low-velocity absorption cores of wind lines (a "filled-in" transition zone); `vplat=0` disables
- `fcov` (optional) - partial-coverage fudge: rescales the wind NLTE line opacity as if only a fraction `fcov` of the stellar disk were covered (picket fence). Weakens saturated lines but also guts unsaturated ones; `fshld` is usually the better dial (default 1 = off)
- `fshld` (optional) - multiplies the self-shielding optical depth of the two-level source function, `S = (1-eps)*K2(fshld*tau)*J_cont + eps*B`: values < 1 mean a leaky slow zone, giving weak red-wing P Cygni emission and partial filling of photospheric resonance cores (typical 0.1; default 1)
- `bspan` (optional) - span of the C1 Hermite bridge between the base/plateau and the pure beta-law, in units of the local slope length (default 4). With a plateau, a large `bspan` makes the bridge (not the beta-law) control the mid-velocity structure and `beta` has little effect; `bspan` = 0.3-1 hands the velocity range above the plateau to the beta-law. Smaller `bspan` puts more column at high velocity (deeper absorption near the terminal-velocity edge)
- `TILT` (optional) - empirical ionization tilt: the weight of stage `iztilt` of element `iatilt` (both spectroscopic, 1 = neutral) is multiplied by `(v/vtilt)**qtilt` before the stage weights are renormalized, so the element total is preserved. `qtilt` < 0 concentrates the ion at low velocity and depletes it in the outer envelope - more absorption along the line of sight, less scattered emission from the extended wind. `vtcut` > 0 turns the monotonic tilt into a peak at `vtcut`. Photospheric layers are untouched (default `qtilt` = 0 = off)
- `COVER` (optional) - flux-level partial coverage, `F = (1-fpcov)*F_phot + fpcov*F_windabs + F_windemis`: a fraction `1-fpcov` of the disk is seen without wind absorption, so saturated troughs floor at `1-fpcov` while the envelope emission is untouched. Unlike `fcov` this does not rescale opacity, so unsaturated lines are unaffected (default 1 = full coverage)
- `GAMMA` (optional, repeatable - one ion per line) - multiplies the photoionization rate of the given ion (spectroscopic stage, 1 = neutral) in the nebular balance, i.e. rescales the ionizing SED at that ion's edge. Unlike density, clumping or dilution this is element-specific, which matters because different ions are ionized in very different parts of the EUV (C IV at 192 A just below the He II edge, N V at 127 A four decades further down). A factor < 1 keeps the ion alive. The effect is flat in velocity, so it cannot substitute for `TILT` if the data demand a gradient
- `COMP` (optional) - discrete absorbing component in front of the wind: a structure at velocity `v0` with Doppler parameter `b` (km/s) covering a fraction `fcov` of the disk. One ground-term column `log(N/g)` (cm^-2) per ion fixes the optical depth in every line of that ion, so doublet ratios are not free parameters. No emission is added (a small covering fraction subtends a small solid angle). The optional trailing `Texc` (K) populates every line of the ion by a Boltzmann factor; absent or <= 0 means a cold absorber and only ground-term lines are included. Use for DAC/CIR-like features that no beta-law can produce

A reasonable starting point for a luminous sdO, following [Krticka et al. 2016](https://ui.adsabs.harvard.edu/abs/2016A%26A...593A.101K/abstract) (Mdot = 1e-12 - 1e-9 Msun/yr, vinf = 500 - 1800 km/s depending on radius and Teff):
```text
2000. 1 0 0
0.2 15.0 1e-10 1000. 1.0 300
WTEMP  0.4
NEB    3 0.1 10.
END
```
`ndrad` is the *total* number of layers, so allow the model ND plus a few hundred wind layers. `NEB 3` uses the differential ionization balance, which needs no extra data files; `WTEMP` is worth having whenever `rmax` is more than a few, since an isothermal wind is too hot far out and overpredicts the P Cygni emission. Keep `velmax` at or above `vinf`, and `rmax` large enough for the velocity to approach `vinf`: the beta-law approaches it only asymptotically, reaching about 1-1/`rmax` of it for `beta` = 1, so `rmax` = 1.2 gets to under 20% while `rmax` = 15 gets to ~93%. A compact envelope produces no wind profile at any mass-loss rate.

For most sdO/Bs winds are undetectable (Mdot < 1e-12) and the wind mode is not needed; at low mass-loss rates the profiles are also insensitive to `vinf`.

Example model for the intermediate He-sdO BD+75 325 (Teff = 52 kK, log g = 5.50, R = 0.1578 Rsun), fitted to the N V doublet in a STIS/E140H spectrum. This is the simplest wind that works - nothing optional is set, and `vtb = 10` on line 8:
```text
2000. 1 0 0
0.1578 10.0 1.0e-13 200. 1.0 300
```
Both N V components show blue-shifted absorption that no static model reproduces, so the wind is real, but it is weak and the constraints are loose: `vinf` = 200 km/s (150-300), `amloss` = 1e-13 Msun/yr to within a factor of a few, limited mainly by blending with unmodelled iron-group lines.

This is not directly comparable to the 1.5e-11 Msun/yr of [Lanz et al. (1997)](https://ui.adsabs.harvard.edu/abs/1997ApJ...485..843L/abstract), who imposed the velocity field on the photosphere alone: that geometry needs ~100x more mass loss to put the same absorbing column at 40-250 km/s.

Example model for a luminous He-sdO (Teff = 55 kK, log g = 4.85, R = 0.7 Rsun; fitted to STIS N V/C IV wind lines, needs `fort.13.tlusty`):
```text
1300. 1 0 0
0.70 25.00 1.3e-11 1550. 1.2 380
CLUMP  50. -200. 10.
WTEMP  0.4
NEB    1 0.1 10.
VLAW   0. 0. 1.0
SHIELD 1.0 1.0
COVER  0.85
COMP   -1454. 149. 1.0 2  7 5 14.301  6 4 13.559
END
```
i.e. clumping peaked at the beta-law graft (D = 50, decaying outward on 200 km/s to a floor of 10), a diluted wind temperature, absolute nebular balance, wind microturbulence 0.1 v, a pure beta-law from the hydrostatic seam (no plateau), 85 % disk coverage, and a discrete absorber at -1454 km/s carrying N V and C IV columns. One block serves both windows.

The base-peaked clumping is what keeps C IV alive in the slow wind: recombination scales with the in-clump electron density, so raising `D` from 10 to 50 near the graft multiplies the C IV fraction by ~3.5 (and C III by ~13) while *reducing* the dominant N V stage by ~2. An earlier version of this model used the empirical `TILT` instead; the clumping law reproduces it exactly in C IV and fits N V slightly better, so no tilt is needed. Note `D = 50` at the base is a large contrast, and it does real work in the fit - treat it as the parameter most in need of an independent check.

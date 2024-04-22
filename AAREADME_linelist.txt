----
sources
----

ArVII
    added from ALL

GaIII
    ALL (O'Reilly & Dunne 1998)
    Nielsen+ 2005
    Morton 2003 (replaced)

GaIV
    TOSS

GaV
    TOSS

GaVI
    TOSS

GeIII
    Naslim+ 2011 for 3 optical lines
    Morton (2000) for 1088.463, 1600.001 AA
    -> now updated with new data by Claudio Mendoza using Cowan's code

GeIV
    Morton 2000 for UV
    ALL for optical lines
        - O'Reilly & Dunne 1998 
        - lines slightly too blue
        - fosc slightly too low?

GeV
    TOSS

GeVI
    TOSS

AsIII
    Morton 2000
    optical data lacking

AsIV
    ALL (Churilov & Joshi 1996)
    Morton 2000

AsV
    Morton 2000

SeIII
    430AA to 1550AA: Tauheed 2012
    no fosc for optical lines

SeIV
    Morton 2000

SeV
    TOSS

KrIII
    Raineri+ 1998

KrIV
    TOSS

KrV
    TOSS

RbIII
    Zhang+ 2014

SrII
    Kurucz
    Fernandez-Menchero+ 2020 for 4077.714, 4215.524 AA
    replaced:
        Naslim+ 2011
        Brage+ 1998
SrIII
    Kurucz/Atoms

SrIV
    TOSS

SrV
    TOSS

YII
    Kurucz

YIII
    4040AA:
        Naslim+ 2011
    range?:
        Redfors 1991
    900-3000AA, 5000-6000AA:
        Fernandez-Menchero+ 2020

YIV
    Loginov & Tuchkin 2001

YV
    183AA to 3000AA: Kurucz/Atoms

ZrIII
    Kurucz

ZrIV
    TOSS, including 1184AA

ZrV
    TOSS

ZrVI
    TOSS

ZrVII
    TOSS

NbIV
    NIST (Tauheed & Reader 2005)

NbV
    Kurucz/Atoms

MoIV
    TOSS

MoV
    TOSS

MoVI
    TOSS

InIII
    Safronova+ 2003

SnIII
    Haris & Tauheed 2012 - only the optical lines

SnIV
    used:
        Kaur+ 2020 (2020arXiv200102011K)
    for comparison:
        Biswas+ 2018
        Safronova+ 2003?

SbIII
    Morton 2000

SbIV
    Morton 2000

SbV
    Safronova+ 2003

TeII
    Zhang+ 2014

TeIII
    Zhang+ 2014

TeIV
    Energy+Config. from NIST, assuming loggf=-1

TeV
    Morton 2000

TeVI
    TOSS

XeIII
    Romeo y Bidegain+ 1998, not all lines added
    Iriarte+ 1997, not added yet
    -> only 3454 to 4061 AA
    Eser & Özdemir 2017, supplemented with NIST energies (loggf = -2.5)
    -> 1 to 2980AA, weak lines due to generally low loggf

XeIV
    TOSS

XeV
    TOSS

BaV
    TOSS

TlIII
    Safronova & Johnson 2004

Pt IV-VI: 2120 lines from NIST 5.10
PtIV
    Azarov & Gayasov (2016ADNDT.108..118A; NIST 5.10)
PtV
    Azarov & Gayasov (2016ADNDT.108..154A; NIST 5.10)
PtVI
    Azarov & Gayasov (2017ADNDT.115..309A; NIST 5.10)

ReIV
    Azarov & Gayasov (2018ADNDT.119..218A; NIST 5.10)
ReV
    Azarov & Gayasov (2018ADNDT.119..175A; NIST 5.10)

OsIII
    Azarov+ (2018ADNDT.121..345A), NIST 5.10

OsIV
    Ryabtsev+ (1998PhyS...57...82R)

IrIV
    Azarov & Gayasov (2016ADNDT.108...81A; NIST 5.10)
IrV
    Gayasov+ (2000): energy levels, lines
    loggf are estimated from line strengths, NOT reliable

HgIV
    Rashid & Tauheed (2021JQSRT.27007668R)

HgV
    Energy levels:
        Raassen+ (1991PhyS...43...44R)
        5d7 6s: Wyart+ (1993PhyS...47..784W)

AuIV
    Zainab+ (2023ApJS..267...12Z)

PbIII
    Morton 2000 (1 FUV)
    Alonso-Medina+ 2009 (rest, optical)

PbIV
    Safronova & Johnson 2004 (some UV, 3962.467,  4049.832)
    Alonso-Medina+ 2013 (rest)
    Morton 2000 (1313)

PbV
    Colon+ 2014

BiIII
    Morton 2000

BiIV
    208 lines from Arya & Tauheed (2022JQSRT.29208353A)
    -> WARNING hyperfine structure is not properly treated
    -> fudged here for 1317, 1207, 1201.5, 1128.8, 1118, 1103.4, 992.8 AA
    Morton 2000 (replaced by Arya & Tauheed 2022)

BiV
    Sarfronova & Johnson 2004

ThIV
    Safronova & Safronova 2013

---
updates
---

2020-03-17:
    removed HeI lines from n>9 levels since they are wrong with the standard 24-level HeI atom
    (even if level dissolution is considered). Their opacity is in the pseudocontinuum.

2020-04-06:
    added KrIII from Raineri+ (1998)

2020-04-07:
    added GeIII from Naslim+ (2011)
        - shifted 417.896 to 417.910 nm
    added some (not all) XeIII from Romeo+ (1998)

2020-04-08:
    shifted GeIV ALL lines, were slightly off AND in vac ...
        GeIV 3333.640 to 3333.790 AA
        GeIV 3554.190 to 3554.260 AA
        GeIV 3676.650 to 3676.750 AA
        GeIV 4979.190 to 4979.950 AA
        GeIV 5072.900 to 5073.300 AA
    shifted
        KrIII 3474.750 to 3474.650 AA
        SrIII 3976.706 to 3976.070 AA
        SrIII 3991.587 to 3992.290 AA
    added
        RbIII from Zhang+ (2014)
            - wavelengths > 2980AA shifted to air

2020-04-13:
    shifted
        ZnIII 5075.243 to 5075.330 AA
        ZnIII 5157.431 to 5157.550 AA
        KrIII 3311.540 to 3311.500 AA
        GeIII 4179.100 to 4179.080 AA
        GeIII 4291.710 to 4291.700 AA
    IMPORTANT: removed duplicate ZrIII lines (all were duplicated)!

2020-04-14:
    shifted:
        ZrIV 5462.333 to 5462.370 AA
        SnIV 3862.051 to 3861.210 AA
        SnIV 4217.184 to 4216.190 AA
    IMPORTANT: removed duplicate SrII lines (all were duplicated)!
    IMPORTANT: removed duplicate SnIV lines (all UV lines were duplicated)!
    added:
        SnIII from Haris & Tauheed (2012) - only the optical lines

2020-04-15:
    replaced old and added:
        SnIV lines from Kaur+ (2020, 2020arXiv200102011K)
    shifted:
        SnIV 3862.048 to 3861.210 AA
        SnIV 4217.140 to 4216.190 AA
    IMPORTANT:
        removed duplicate UV lines for Ga - Th and II to IX
        this also removed some Ba II lines that are duplicates in the kurucz lists as well
        those might be real, but are easy to add again
    added:
        optical YV from Kurucz/Atoms

2020-04-19:
    shifted: 
        SIV 3341.464 to 3341.530 AA
        NIII 3353.975 to 3353.940 AA
        NIII 3365.798 to 3365.815 AA

2020-04-26:
    shifted:
        GeIV 3320.410 to 3320.563 AA
        GeIV 3333.790 to 3333.787 AA
        GeIV 3676.750 to 3676.740 AA
        GeIV 6206.100 to 6205.600 AA
        GeIII 4179.080 to 4179.070 AA

2020-04-27:
    removed:
        CIII 3506.783 AA

2020-04-29:
    shifted:
        GeIV 3320.563 to 3320.530 AA
        GeIV 3554.260 to 3554.255 AA
        GeIV 3676.740 to 3676.735 AA
        KrIII 3311.540 to 3311.490 AA
        SrIII 3430.780 to 3430.775 AA
        YIII 4039.602 to 4039.575 AA

2020-05-08:
    new loggf:
        SrII 4077.714 AA:
             0.148 (Kurucz) to  0.164 (Fernandez-Menchero+ 2020)
        SrII 4215.524 AA:
            -0.173 (Kurucz) to -0.151 (Fernandez-Menchero+ 2020)
        
2020-05-10:
    shifted (updated shifts):
\ion{Zn}{iii}   &   5075.243   &   5075.330 & $+0.087$ \\
\ion{Zn}{iii}   &   5157.431   &   5157.580 & $+0.149$ \\[2pt]
\ion{Ge}{iii}   &   4178.960   &   4179.078 & $+0.118$ \\
\ion{Ge}{iii}   &   4260.850   &   4260.865 & $+0.015$ \\
\ion{Ge}{iii}   &   4291.710   &   4291.700 & $-0.010$ \\[2pt]
\ion{Ge}{iv}    &   3320.410   &   3320.530 & $+0.120$ \\
\ion{Ge}{iv}    &   3333.640   &   3333.785 & $+0.145$ \\
\ion{Ge}{iv}    &   3554.190   &   3554.257 & $+0.067$ \\
\ion{Ge}{iv}    &   3676.650   &   3676.735 & $+0.085$ \\
\ion{Ge}{iv}    &   4979.190   &   4979.987 & $+0.797$ \\
\ion{Ge}{iv}    &   5072.900   &   5073.330 & $+0.430$ \\[2pt]
\ion{Kr}{iii}   &   3311.540   &   3311.490 & $-0.050$ \\
\ion{Kr}{iii}   &   3474.750   &   3474.650 & $-0.100$ \\[2pt]
\ion{Sr}{iii}   &   3430.780   &   3430.775 & $-0.005$ \\
\ion{Sr}{iii}   &   3976.706   &   3976.033 & $-0.673$ \\
\ion{Sr}{iii}   &   3991.587   &   3992.272 & $+0.685$ \\[2pt]
\ion{Y}{iii}    &   4039.602   &   4039.576 & $-0.026$ \\[2pt]
\ion{Zr}{iv}    &   5462.333   &   5462.380 & $+0.047$ \\
\ion{Zr}{iv}    &   5779.843   &   5779.880 & $+0.037$ \\[2pt]
\ion{Sn}{iv}    &   3862.051   &   3861.207 & $-0.844$ \\
\ion{Sn}{iv}    &   4217.184   &   4216.192 & $-0.992$ \\

2020-06-03:
    updated:
        S IV 1072.974 AA and S IV 1062.664 AA:
            removed gamma_stark and gamma_vdW (underestimated)
            should update with better values?
    shifted:
        S IV 1062.664 to 1062.678 AA
            
2020-06-07:
    updated:
        Si IV 1393.755 AA and Si IV 1402.770 AA:
            updated to kurucz 2017 loggf and stark (-> weaker lines)
            now consistent with SiIII/SiIV balance from FUSE (also using new kurucz)

2020-06-08:
    updated:
        Zr IV 1183.973:
            loggf -0.930 (TOSS) -> 0.000 (Chayer 2006)

2020-06-20:
    added:
        YIII optical, FUV, NUV from Fernandez-Menchero (2020)
        did not replace loggf for lines 1200 < 1800 AA (still Redfors 1991)
        YIII 4039 still Naslim (2011)
        YIII optical lines with updated positions from Dorsch (2020) when available, otherwise NIST
    updated:
        Zr IV 1183.973:
            - loggf 0.000 (Chayer 2006) -> -0.930 (TOSS)
              since Fernandez-Menchero 2020 (-0.95) agrees with TOSS
            - Radiative damping width 9.249 from Fernandez-Menchero 2020

2020-08-11:
    removed:
        duplicate optical CaII lines (which lead to much to strong lines)
    replaced:
        CaII oscialltor strengths for opt. res and IR triplet with NIST values

2020-08-27:
    shifted:
        S  IV  3097.273 -> 3097.326
        S  IV  3117.615 -> 3117.658
        Si III 3185.122 -> 3185.138
        S  IV  3300.633 -> 3300.702
        S  IV  3308.717 -> 3308.800
        S  IV  3308.804 -> 3308.887
        S  IV  3330.709 -> 3330.768
        P  IV  3347.739 -> 3347.756
        S  IV  3363.047 -> 3363.097
        S  IV  3369.565 -> 3369.663
        Ca III 3372.679 -> 3372.695
        S  III 3387.092 -> 3387.111
        S  IV  3395.096 -> 3395.162
        S  III 3497.28  -> 3497.336
        Ar III 3511.148 -> 3511.171
        Ar III 3514.2   -> 3514.219
        Fe IV  3581.303 -> 3581.397
        Si III 3590.465 -> 3590.484
        Fe III 3603.888 -> 3603.876
        Ar III 3637.873 -> 3637.887
        S  III 3656.56  -> 3656.598
        S  III 3661.942 -> 3661.991
        Fe IV  3667.57  -> 3667.639
        Fe IV  3678.411 -> 3678.464
        S  III 3717.717 -> 3717.762
        N  III 3745.952 -> 3745.929
        S  III 3747.855 -> 3747.879
        S  III 3750.713 -> 3750.735
        N  III 3752.631 -> 3752.590
        N  III 3771.033 -> 3771.065
        N  III 3771.360 -> 3771.416
        Si IV  3773.15  -> 3773.129
        S  III 3778.846 -> 3778.888
        Si III 3791.439 -> 3791.400
        N  III 3792.967 -> 3792.986
        Si III 3796.124 -> 3796.081
        Si III 3796.203 -> 3796.160
        Si III 3806.526 -> 3806.499
        Si III 3806.700 -> 3806.673
        Si III 3806.779 -> 3806.752
        S  III 3831.815 -> 3831.854
        S  III 3837.726 -> 3837.779
        S  III 3838.268 -> 3838.321
        Fe IV  3892.314 -> 3892.432
        N  III 3942.879 -> 3942.804
        N  II  3946.492 -> 3946.416
        S  III 3983.723 -> 3983.764
        S  III 3985.924 -> 3985.964
        N  II  4073.053 -> 4073.041
        N  III 4097.355 -> 4097.322
        N  III 4103.393 -> 4103.387
        S  III 4253.499 -> 4253.580
        S  III 4354.492 -> 4354.558
        S  III 4361.468 -> 4361.532
        S  III 4364.661 -> 4364.727
        S  IV  4485.642 -> 4485.745
        S  IV  4486.548 -> 4486.434
        S  IV  4504.114 -> 4504.209
        N  III 4510.882 -> 4510.854
        N  III 4510.963 -> 4510.935
        N  III 4523.557 -> 4523.572
        N  III 4527.859 -> 4527.834
        N  III 4530.856 -> 4530.904
        N  III 4534.575 -> 4534.556
        N  III 4535.048 -> 4535.065
        N  III 4646.036 -> 4646.477
        S  IV  4659.179 -> 4659.244
        S  III 4802.719 -> 4802.814
        Si III 4813.333 -> 4813.302
        Si III 4819.712 -> 4819.681
        Si III 4819.814 -> 4819.783
        Si III 4828.950 -> 4828.919
        Si III 4829.111 -> 4829.080
        N  III 4858.981 -> 4858.849
        N  III 4867.119 -> 4867.100
        N  III 4867.166 -> 4867.147
        N  III 4873.596 -> 4873.547
        N  III 4884.144 -> 4884.113
        N  III 4899.103 -> 4899.048
        N  III 4904.776 -> 4904.711
        Fe IV  5026.003 -> 5026.171
        S  III 5160.085 -> 5160.140
        S  III 5219.307 -> 5219.407
        N  III 5269.042 -> 5267.118
        N  III 5352.461 -> 5352.351
        S  IV  5488.275 -> 5488.328
        S  IV  5497.782 -> 5497.816
        Si III 5739.734 -> 5739.751
        N  III 5847.940 -> 5847.771
        N  III 6450.788 -> 6450.957
        N  III 6454.078 -> 6454.130
        N  III 6463.09  -> 6463.156
        N  III 6467.02  -> 6467.063
        N  III 6478.755 -> 6478.784
        Si IV  6667.569 -> 6667.525
        Si IV  6701.205 -> 6701.171
        Si IV  6701.250 -> 6701.216
        Si III 6851.198 -> 6851.075
        Si III 6851.762 -> 6851.642
        S  IV  7003.273 -> 7003.375
        S  IV  3292.209 -> 3292.302
        Fe IV  3236.876 -> 3236.938 
        Fe IV  3233.019 -> 3233.0965
        Fe IV  3233.128 -> 3233.2055
        Si III 3210.557 -> 3210.5245
        Si III 3210.628 -> 3210.5955
        Si III 3486.825 -> 3486.8355
        Si III 3486.927 -> 3486.9375
        Si III 3486.972 -> 3486.9825
        Si III 3487.039 -> 3487.0495
        Si III 3487.073 -> 3487.0835
        Si IV  3762.431 -> 3762.406
        Si IV  3762.448 -> 3762.423

2020-08-31:
        shifted YIII lines in FUSE, see update.txt for more details
        removed GaIII 1507.957 AA, which is not real

2020-09-09:
        removed duplicate NaI doublet lines
        changed loggf:
            NeII 3454.772: -0.808 (Kurucz) ->  0.06 (NIST)
            NeII 3457.084:  0.190 (Kurucz) -> -0.97 (NIST)
            NeII 3457.005:  0.369 (Kurucz) -> -1.00 (guess)
            SIV  3101.001:  0.697 (Kurucz) -> -2.00 (guess, not observed)
        changed Stark broadening constants for FUSE SiIV to old values
        to match optical Si abundance for BD+25_4655:
            SiIV 1122.485: -7.07 (Kurucz) -> -5.82 (old synspec)
            SiIV 1128.340: -7.08 (Kurucz) -> -5.82 (old synspec)

2020-09-11:
        changed loggf:
            ZrIV 1183.973: -0.930 (Kurucz, TOSS) -> 0.00 (Chayer 2006, also better for HZ44)

2020-09-12:
        changed Stark broadening constants for IUE SiIV to old values
        to match optical Si abundance for BD+25_4655:
            SiIV 1393.755: -6.94 (Kurucz) -> -6.00 (old synspec)
            SiIV 1402.770: -6.94 (Kurucz) -> -6.00 (old synspec)

2020-10-13:
        removed all exact duplicate lines: 250165 (or 11%!)
        updated positons:
            Pb IV  4175.579 -> 4174.453
            Pb IV  4535.730 -> 4534.421
            Pb IV  4536.130 -> 4534.821

2020-12-01:
        added 18 optical Pb III lines from Alonso-Medina+ (2009)

2020-12-02:
        added 5 optical Pb IV lines from Alonso-Medina+ (2011)

2020-12-02:
        loggf for PbIV 4496 from Naslim+ (2013) to 
        Alonso-Medina+ (2011) value (-0.237 -> -0.437)

2021-11-23:        
            Fe III 1033.066 -> 1033.090
            P   IV 1033.112 -> 1033.130

2021-11-26:
            As  IV 1299.280 -> 1299.254
            Ge  IV 1494.890 -> 1494.830

2021-11-27:
            Kr III  987.230 ->  987.527

2021-11-28:
            added some YIV lines from Loginov & Tuchkin 2001
            Y   IV 1009.875 -> 1009.798
            Mo  IV 1350.922 -> 1350.756
            added TeIV lines based on NIST energies and configurations only (loggf=-1)

2021-11-29:
            Te  IV 1168.388 -> 1168.350
            Sc III 1168.607 -> 1168.517
            Cu  IV 1105.507 -> 1105.383
            Fe  IV 1495.178 -> 1495.155
            Zn  IV 1298.506 -> 1298.547

2021-12-03:
            moved two TeIV lines from to air wavelengths (from level energies)

2023-0?-??:
        changed loggf back - the Chayer value is incorrect:
            ZrIV 1183.973: -0.930 (Kurucz, TOSS) <- 0.00 (Chayer 2006, also better for HZ44)
        changed Stark broadening for CIV 1550AA resonance doublet
            -7.17 (new Kurucz) -> -6.1 (old Kurucz/Tlusty value)


2023-09-08:
CIII
    1623.253 -> 1623.137

PIII 
    1344.326 -> 1344.317

Ge IV
    1500.610 -> 1500.549

Hg IV
    1239.781 -> 1239.792
    1296.951 -> 1296.972
    1343.779 -> 1343.783
    1360.934 -> 1360.952
    1386.286 -> 1386.298
    1414.911 -> 1414.933
    1447.318 -> 1447.338
    1454.150 -> 1454.164
    1465.718 -> 1465.725
    1466.763 -> 1466.776
    1472.425 -> 1472.436
    1481.324 -> 1481.336
    1481.507 -> 1481.510
    1488.218 -> 1488.233
    1513.730 -> 1513.744

PbIII 
    1167.000 -> 1166.940
    1203.500 -> 1203.479
    1250.400 -> 1250.430
    1266.800 -> 1266.770
    1274.500 -> 1274.536
    1308.100 -> 1308.084
    1553.021 -> 1553.004



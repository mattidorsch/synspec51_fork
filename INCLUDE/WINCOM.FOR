      PARAMETER (MRCORE=100,
     *           MKU=MDEPTH+MRCORE,
     *           MEXT=MKU)
c     number of core rays.  Fixed rather than user-selectable: the
c     emergent flux is converged here to 0.03% against twice as many,
c     while fewer than ~30 shifts the continuum level (the mu
c     quadrature over the disk) rather than the line profile.
c     Must not exceed MRCORE.
      PARAMETER (NRCOR0=40)
      COMMON/COMANG/BMU(MKU,MDEPTH),WMUJ(MKU,MDEPTH),WMUH(MKU)
      COMMON/CORADI/RD(MDEPTH),RCORE,RFNORM,PIM(MKU),RAD1(MDEPTH),
     *              NUD(MKU),NUDF(MKU),KMU,NREXT,
     *              NRCORE,NDF
      COMMON/CORAF/DELZF(MEXT,MRPF ),DFRQF(MEXT,2*MRPF )
      COMMON/COVEL/VEL(MDEPTH),DFRQ(MKU,2*MDEPTH),DVD(MDEPTH),
     *             XMDOT,XMD4,BETAV,VINF
      COMMON/EXTMOD/FFQ(MOPAC),FFQV(MOPAC),RDF(MDEPF ),DENSF(MDEPF ),
     *             VELF(MEXT,MRPF ),DRAY(MEXT,2*MRPF ),
     *             KRAY(MEXT,2*MRPF ),NOPAC
      COMMON/CORLAY/DLAY(MDEPTH),KLAY(MDEPTH)
      COMMON/WINDTP/TWFLOOR,NRXW,IWNEB,IWABS,FCOVW,FSHLD,
     *              QTILT,VTILT,IATILT,IZTILT,VTCUT,FPCOV
c     discrete absorbing component(s) in front of the wind:
c     velocity, Doppler b (km/s), covering fraction, excitation
c     temperature (<=0: ground term only), and per-ion ground-term
c     column N/g (cm-2) for NCOMP ions
      PARAMETER (MCOMP=10)
      COMMON/WCOMPP/VCOMP,BCOMP,FCCOMP,TCOMP,CLCOMP(MCOMP),
     *              NCOMP,IZCOMP(MCOMP),IACOMP(MCOMP)
      COMMON/CONJNU/XJCON(MFREQC,MDEPF)
      COMMON/WTAULN/TAUWL(MDEPTH)
      PARAMETER (MREC=80)
      COMMON/WNEBPH/GAMPH(MIOEX),RRCF(6,MREC),DRC(4,MREC),
     *              IZREC(MREC),IATREC(MREC),NRECTB
c     per-ion scale factors on the photoionization rate GAMPH, i.e. on
c     the ionizing SED at that ion's edge (element-specific, unlike
c     density, clumping or dilution)
      PARAMETER (MGSC=10)
      COMMON/WGSCAL/GSCF(MGSC),NGSC,IZGSC(MGSC),IAGSC(MGSC)
c     optional depth-dependent turbulent velocity (fort.55 VTURB line):
c     v_turb rises from VTDEEP deep down to VTTOP high in the
c     atmosphere, over a tanh transition centred on column mass
c     10**VTLGM0 g/cm2 and VTDLGM dex wide.  NVTDEP=0 keeps the usual
c     depth-independent VTB.
      COMMON/VTDEPT/VTTOP,VTDEEP,VTLGM0,VTDLGM,NVTDEP
      COMMON/OPAVEL/WDIL(MDEPTH),PLANW(MDEPTH),TRAD(MTRAD,MDEPTH),
     *              DENSCON(MDEPTH)

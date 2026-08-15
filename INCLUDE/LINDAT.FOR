      PARAMETER (MLIN0   = 500000, 
     *           MGRIEM  =     40,
     *           MNLT    =   2000,
     *           MSPHE2  =     20,
     *           MLIN    =  10000,
     *           MPRF    =  MLIN0)
C
      PARAMETER (MLINM0  =3000000,
     *           MLINM   =  10000,
     *           MMLIST  =      2)
c      PARAMETER (MLINM0  = 20,
c     *           MLINM   =  2)
C
       REAL*4       EXCL0(MLIN0),
     *              EXCU0(MLIN0),
     *              GF0(MLIN0),
     *              QL0(MLIN0), ! store Js for lin. Zeeman effect
     *              QU0(MLIN0),
     *              EXTIN(MLIN0),
     *              BNUL(MLIN0),
     *              GAMR0(MPRF),
     *              GS0(MPRF),
     *              GW0(MPRF),
     *              WGR0(4,MGRIEM),
     *              DGR0(4,MGRIEM),
     *              EXCLM(MLINM0,MMLIST),
     *              GFM(MLINM0,MMLIST),
     *              EXTINM(MLINM0,MMLIST),
     *              GRM(MLINM0,MMLIST),
     *              GSM(MLINM0,MMLIST),
     *              GWM(MLINM0,MMLIST)
C     
      COMMON/LINTOT/FREQ0(MLIN0),
     *              EXCL0,
     *              EXCU0,
     *              QL0,
     *              QU0,
     *              GF0,
     *              EXTIN,
     *              BNUL,
     *              INDAT(MLIN0),
     *              INDNLT(MLIN0),
     *              ILOWN(MLIN0),
     *              IUPN(MLIN0),
     *              IJCONT(MLIN0),
     *              INDLIN(MLIN),
     *              INDLIP(MLIN),
     *              NLIN0,NLIN,
     *              NNLT,NGRIEM
C
C     Quantum numbers of the two levels of each line, as supplied by an
C     extended (synspec54-style) line list: 2S+1, L and the parity, for
C     the lower and the upper level.  -1 means "not specified", which is
C     also what a standard 11-column list leaves behind.  They are used
C     to associate the line with the right explicit level (NLTSET) and
C     to obtain Lande factors for the Zeeman treatment (S=(ISQ-1)/2).
C
      COMMON/LINQNM/ISQL0(MLIN0),ILQL0(MLIN0),IPQL0(MLIN0),
     *              ISQU0(MLIN0),ILQU0(MLIN0),IPQU0(MLIN0),
     *              IEXTLL
C
      COMMON/MOLTOT/FREQM(MLINM0,MMLIST),
     *              EXCLM,
     *              GFM,
     *              EXTINM,
     *              GRM,
     *              GSM,
     *              GWM,
     *              INDATM(MLINM0,MMLIST),
     *              INMLIN(MLINM,MMLIST),
     *              INMLIP(MLINM,MMLIST),
     *              NLINM0(MMLIST),
     *              NLINML(MMLIST),
     *              IUNITM(MMLIST),
     *              NMLIST
C
      COMMON/LINPRF/GAMR0,
     *              GS0,
     *              GW0,
     *              WGR0,
     *              DGR0,
     *              IPRF0(MPRF),
     *              ISPRF(MPRF),
     *              IGRIEM(MPRF),
     *              ISP0(MSPHE2),NSP
C
      COMMON/LINNLT/ABCENT(MNLT,MDEPTH),
     *              SLIN(MNLT,MDEPTH)
C
      COMMON/LINDEP/PLAN(MDEPTH),
     *              STIM(MDEPTH),
     *              EXHK(MDEPTH)
C
      COMMON/LINCTR/DFRCON,IJCNTR(MLIN),IJCMTR(MLINM,MMLIST)
c     blue-shadows-red doublet coupling: for each line in the current
c     list, the position of the nearest BLUER line of the same ion
c     sharing the same lower level (0 if none)
      COMMON/DBLSHD/IPARTN(MLIN)
      COMMON/MLINRE/FRLASM(MMLIST),ALASTM(MMLIST),
     *              NXTSEM(MMLIST),IPRSEM(MMLIST),IREADM(MMLIST)


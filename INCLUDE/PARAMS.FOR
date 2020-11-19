C
C     Parameters that specify dimensions of arrays
C
      IMPLICIT REAL*8 (A-H, O-Z)
      character typat*4
      PARAMETER (MATEX = 99,   
     *           MIOEX = 300,
     *           MLEVEL= 3000,
     *           MDEPTH= 200,
     *           MDEPF = 500,
     *           MFREQ = 30,
     *           MFREQC= 2000,
     *           MOPAC = MFREQ,
     *           MMU   = 20,
     *           MCROSS= MLEVEL,
     *           MFIT  = 1650,
     *           MFCRA =  1200,
     *           MTRAD =  3,
     *           MATOM =  99,
     *           MATOMBIG = 99,
     *           MION  = 300,
     *           MION0 = 9,
     *           MMOLEC= 340,
     *           MPHOT = 10,
     *           MZZ   =  2,
     *           MMER  =  2,
     *           NLMX  = 80,
     *           MI1   = MION0,
     *           MLINH = 78,
     *           MHT   = 7,
     *           MHE   = 20,
     *           MHWL  = 65,
     *           MLHE = 46, ! max. number of lines in HeI table
     *           MWHE = 1153, ! max. number of wavelengths per HeI line
     *           MTHE = 3, ! max. number of temp. for HeI table
     *           MDHE = 25) ! max. number of electron densities per HeI line
C
C     Basic physical constants
C
      PARAMETER (H     = 6.6261D-27,      
     *           CL    = 2.997925D10,    
     *           BOLK  = 1.38054D-16,   
     *           HK    = 4.79928144D-11,
     *           EH    = 2.17853041D-11,
     *           BN    = 1.4743D-2,     
     *           SIGE  = 6.6516D-25,   
     *           PI4H  = 1.8966D27,   
     *           HMASS = 1.67333D-24)
C
C     Unit number
C
      PARAMETER (IBUFF=95)
C
C     Basic parameters
C
      COMMON/BASNUM/NATOM,
     *              NION, 
     *              NLEVEL,
     *              ND,    
     *              NFREQ,NFROBS,NFREQC,
     *              NMU 
      COMMON/INPPAR/TEFF, 
     *              GRAV,
     *              YTOT(MDEPTH),
     *              WMM(MDEPTH),
     *              WMY(MDEPTH),
     *              vaclim 
      COMMON/BASICM/IMODE,
     *              IFREQ,
     *              INLTE,
     *              IDSTD,
     *              IFWIN
      COMMON/INTKEY/INMOD,INTRPL,ICHANG,ICHEMC,IATREF,ICONTL
      COMMON/LBLANK/IBLANK,NBLANK
      COMMON/NXTINI/ALM00,ALST00,NXTSET,INLIST,ALAMBE,DLAMLO,
     .              APREV,FRMAX
      COMMON/IPRNTR/IPRIN
C
C     Parameters for explicit atoms
C
      COMMON/ATOPAR/AMASS(MATEX),
     *              ABUND(MATEX,MDEPTH),
     *              RELAB(MATEX,MDEPTH),
     *              NUMAT(MATEX),
     *              N0A(MATEX), 
     *              NKA(MATEX),
     *              SABND(MATEX)
C
C     Parameters for explicit ions
C
      COMMON/IONPAR/FF(MIOEX), 
     *              NFIRST(MIOEX),
     *              NLAST(MIOEX),
     *              NNEXT(MIOEX),
     *              IUPSUM(MIOEX),
     *              IZ(MIOEX),
     *              IFREE(MIOEX),
     *              INBFCS(MIOEX)
C
C     Parameters for explicit levels
C
      COMMON/LEVPAR/ENION(MLEVEL),
     *              G(MLEVEL), 
     *              NQUANT(MLEVEL),
     *              IATM(MLEVEL), 
     *              IEL(MLEVEL), 
     *              ILK(MLEVEL),
     *              ifwop(mlevel) 
C
C     Parameters for all considered transitions
C
      COMMON/TRAPAR/IBF(MLEVEL),
     *              S0BF(MLEVEL),
     *              ALFBF(MLEVEL),
     *              BETBF(MLEVEL),
     *              GAMBF(MLEVEL)
C
      COMMON/MRGPAR/SGM0(MMER),
     *              FRCH(MMER),
     *              SGEXT1(MMER,MDEPTH),
     *              GMER(MMER,MDEPTH),
     *              SGMSUM(NLMX,MMER,MDEPTH),
     *              SGMG(MMER,MDEPTH),
     *              IMRG(MLEVEL),
     *              IIMER(MMER)
C
      COMMON/DWNPAR/ELEC23(MDEPTH),
     *              ACOR(MDEPTH),
     *              Z3(MZZ),
     *              DWC1(MZZ,MDEPTH),
     *              DWC2(MDEPTH),
     *              FACIONS(MDEPTH)
C
C     Auxiliary parameters
C
      COMMON/AUXIND/IATH,IELH,IELHM,N0H,N1H,NKH,N0HN,N0M,
     *              IATHE,IELHE1,IELHE2
      COMMON/OPCPAR/IOPADD,IOPHMI,IOPH2P,IRSCT,IOPHLI,IOPHE1,IOPHE2,
     *              IOHEMI,IOHE2P 
      COMMON/MOLFLG/MOLIND(1000),NMOLEC,IFMOL
 
C
C     Parameters for atoms considered in line blanketing opacity
C
      LOGICAL LGR(MATOM),LRM(MATOM)
      COMMON/PFSTDS/PFSTD(MION,MATOM),MODPF(MATOM)
      COMMON/ADDPOP/RR(MATOM,MION)
      COMMON/ATOBLN/ENEV(MATOM,MI1),AMAS(MATOM),ABND(MATOM),
     *       ABNDD(MATOM,MDEPTH),ABNREF(MDEPTH),TYPAT(MATOM),
     *       IATEX(MATOM),INPOT(MATOM,MION0)
      COMMON/ATOINI/NATOMS,IONIZ(MATOM),LGR,LRM
c
c     parameters for hydrogen Stark broadening tables
c
      COMMON/HYDPRF/PRFHYD(MLINH,MDEPTH,MHWL),
     *              WLHYD(MLINH,MHWL),
     *              NWLHYD(MLINH),
     *              WL(MHWL,MLINH),
     *              XT(MHT,MLINH),
     *              XNE(MHE,MLINH),
     *              PRF(MHWL,MHT,MHE),
     *              NWLH(MLINH),
     *              NTH(MLINH),
     *              NEH(MLINH),
     *              ILIN0(4,22),
     *              ILEMKE
c
      COMMON/HE1PRF/NLHE,NTHE,NDHE(MLHE),THE(MTHE),DHE(MLHE,MDHE),
     *              NWHE(MLHE),D0HE(MLHE),ILOWHE(MLHE),IUPHE(MLHE),
     *              FHE(MLHE),WAVHE(MLHE),WSHE(MLHE,MTHE),
     *              DSHE(MLHE,MTHE),ASHE(MLHE,MTHE),DREFHE(MLHE),
     *              WHE(MLHE,MWHE),PROFHE(MLHE,MTHE,MDHE,MWHE),
     *              THEL(MTHE),DHEL(MLHE,MDHE),D1HE(MLHE)
c
      COMMON/AUXHYD/XK,FXK,BETAD,DBETA,BERGFC,CUTLYM,CUTBAL
      COMMON/HHEPRF/IHYDPR,IHE1PR,IHE2PR
      COMMON/HYLPAR/IHYL,ILOWH,M10,M20
      COMMON/HYLPAW/IHYLW(MFREQ),ILOWHW(MFREQ),
     *              M10W(MFREQ),M20W(MFREQ)
      COMMON/HE2PAR/IFHE2,IHE2L,ILWHE2,MHE10,MHE20
      COMMON/HE2PAW/IHE2LW(MFREQ),ILWHEW(MFREQ),
     *              MHE10W(MFREQ),MHE20W(MFREQ)
C
C     parameters for the macroscopic velocity field and angles
C
      COMMON/VELPAR/ANGL(MMU),WANGL(MMU),VELC(MDEPTH),NMU0,IFLUX
c
c     Parameters for the He2+ free-free opacity
c
      common/ophe2p/ nwav,ntemp,xwav(40),xtemp(8),he2pff(40,8)


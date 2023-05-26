import 'package:flutter_application_1/modules/app/auth/SignIn/ForgetPassword/forget.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/ForgetPassword/forgotPasswordSmsVerification/forgotPasswordSmsVerification.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/ResetPassword/resetPassword.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignUp/Email/email.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignUp/EmailVerification/emailverification.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignUp/Infos/info.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignUp/Password/password.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignUp/Position/google_place_api.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignUp/SmsVerification/smsverification.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignUp/Status/Candidate/candidate.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignUp/Telephone/telephone.view.dart';
import 'package:flutter_application_1/modules/app/auth/Splash/splash.view.dart';
import 'package:flutter_application_1/modules/app/auth/auth.view.dart';
import 'package:flutter_application_1/modules/app/auth/SignUp/Status/Recruiter/recruiter.view.dart';
import 'package:flutter_application_1/modules/app/error/Network/network_error.view.dart';
import 'package:flutter_application_1/modules/app/error/NothingFound/nothing_found.view.dart';
import 'package:flutter_application_1/modules/app/error/SignIn/signin_error.view.dart';
import 'package:flutter_application_1/modules/app/error/access/Camera/camera_access.view.dart';
import 'package:flutter_application_1/modules/app/error/access/File/file_access.view.dart';
import 'package:flutter_application_1/modules/app/error/access/GPS/gps_access.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Basic/basic_exemple.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Candidate/Candidate_calendar.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Candidate/addCandidateAvailability.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Candidate/candidateAvailability.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Complex/complex_exemple.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Recruiter/PharmacieInfo/PharmacieInfo.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Recruiter/ajouterPharmacie/RecuAjouterPharmacie.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Recruiter/besoin/Recruiter_calendar.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Recruiter/declaration.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Recruiter/recruAvailability/recruAvailability.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/Contact/contact.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/Favorite/Candidate/candidate_favotite.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/GoogleMap/SearchingAddress/searching_address.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/GoogleMap/ViewingMap/viewing_map.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/Recommend/recommend.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/Settings/setting.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_candidate/Details/Future/detail_future_candidate.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_candidate/Details/Now/detail_now_candidate.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_candidate/Details/Pass/detail_pass_candidate.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_candidate/dutyCandidate.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_candidate/rDVFixeCandidate.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Description/description.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/Future/ajouteMission/ajoute_mission.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/Future/detail_future_recruiter.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/Future/editAVLP/editAVLP.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/Now/detail_now_recruiter.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/Pass/detail_pass_recruiter.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/editAVLU/editAVLU.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/showUserCVtoPhar/showUserCVtoPhar.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/dutyRecruiter.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/rDVFixeRecru.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/Profile/modify/modify_profile.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/document/document.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/experience/experience.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/favorite/Pharmacie/pharmacie_favotite.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/favorite/bookmarks_page.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/logout/logout.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/my.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/ability/ability.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/Profile/profile.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/my_recruiter.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/pharmacie/EditMyPharmacy/editMyPharmacy.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/pharmacie/ajouterPharmacie/ajouterPharmacie.view.dart';
import 'package:flutter_application_1/modules/app/homepage/My/pharmacie/pharmacie.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Search/demande.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Search/demandeToPhar.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Search/search.view.dart';
import 'package:flutter_application_1/modules/app/homepage/Welcome/welcome.view.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.view.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.view.dart';
import 'package:flutter_application_1/modules/app/timeout/EmailVerification/emailverification_timeout.view.dart';
import 'package:flutter_application_1/modules/app/timeout/SignIn/signin_timeout.view.dart';
import 'package:flutter_application_1/shared/onBoard.dart';
import 'package:get/get.dart';

part 'app.routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashView(), children: [
      GetPage(
        name: Routes.auth,
        page: () => const AuthView(),
      )
    ]),
    GetPage(
      name: Routes.auth,
      page: () => const AuthView(),
      children: [
        GetPage(
          name: Routes.signIn,
          page: () => const SignInView(),
          children: [
            GetPage(
                name: Routes.forgetPassword,
                page: () => const ForgetPasswordView(),
                children: [
                  GetPage(
                      name: Routes.forgotPasswordSmsVerificationRoute,
                      page: () => const ForgotPasswordSmsVerificationView())
                ])
          ],
        ),
        GetPage(
          name: Routes.recruiter,
          page: () => const RecruiterView(),
        ),
        GetPage(
          name: Routes.candidate,
          page: () => const CandidateView(),
        ),
        GetPage(
            name: Routes.telephone,
            page: () => const TelephoneView(),
            children: [
              GetPage(
                  name: Routes.smsVerification,
                  page: () => const SmsVerificationView(),
                  children: [
                    GetPage(
                        name: Routes.email,
                        page: () => const EmailView(),
                        children: [
                          GetPage(
                            name: Routes.emailVerification,
                            page: () => const EmailVerificationView(),
                          )
                        ])
                  ]),
            ]),
        GetPage(
          name: Routes.infos,
          page: () => const InfoView(),
        ),
      ],
    ),
    GetPage(name: Routes.onBoard, page: () => const OnBoard()),
    GetPage(name: Routes.password, page: () => const PasswordView()),
    GetPage(name: Routes.homepage, page: () => const HomepageView()),
    GetPage(name: Routes.welcome, page: () => const WelcomeView()),
    GetPage(name: Routes.menu, page: () => const MyView()),
    GetPage(name: Routes.document, page: () => const DocumentView()),
    GetPage(name: Routes.experience, page: () => const ExperienceView()),
    GetPage(name: Routes.logout, page: () => const LogoutView()),
    GetPage(name: Routes.ability, page: () => const AbilityView()),
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.profile, page: () => ProfileView()),
    GetPage(name: Routes.modifyProfile, page: () => const ModifiyProfileView()),
    GetPage(name: Routes.contact, page: () => const ContactView()),
    // GetPage(name: Routes.googleMap, page: () => const GoogleMapView()),
    GetPage(
        name: Routes.searchingAddress,
        page: () => const SearchingAddressView()),
    GetPage(name: Routes.viewingMap, page: () => ViewingMapView()),
    GetPage(name: Routes.recommend, page: () => const RecommendView()),
    GetPage(name: Routes.my, page: () => const MyView()),
    GetPage(name: Routes.dutyCandidate, page: () => const DutyCandidateView()),
    GetPage(name: Routes.dutyRecruiter, page: () => DutyRecruiterView()),
    GetPage(
        name: Routes.googlePlaceApi, page: () => const GooglePlaceApiView()),
    GetPage(name: Routes.setting, page: () => const SettingView()),
    GetPage(name: Routes.search, page: () => const SearchView()),
    GetPage(name: Routes.nothingFound, page: () => const NothingFindView()),
    GetPage(name: Routes.signInError, page: () => const SignInErrorView()),
    GetPage(name: Routes.networkError, page: () => const NetWorkErrorView()),
    GetPage(name: Routes.gpsAccess, page: () => const GpsAccessView()),
    GetPage(name: Routes.cameraAccess, page: () => const CameraAccessView()),
    GetPage(name: Routes.fileAccess, page: () => const FileAccessView()),
    GetPage(name: Routes.signInTimeOut, page: () => const SigiInTimeOutView()),
    GetPage(
        name: Routes.emailVerificationTimeOut,
        page: () => const EmailVerificationTimeOutView()),
    GetPage(name: Routes.resetPassword, page: () => const ResetPasswordView()),
    GetPage(
        name: Routes.forgotPasswordSmsVerification,
        page: () => const ForgotPasswordSmsVerificationView()),
    GetPage(
        name: Routes.pharmacieFavorite,
        page: () => const PharmacieFavoriteView()),
    GetPage(
        name: Routes.candidateFavorite,
        page: () => const CandidateFavoriteView()),
    GetPage(name: Routes.bookmarksPage, page: () => const BookmarksPageView()),
    GetPage(
        name: Routes.recruiterCalendar, page: () => RecruiterCalendarView()),
    GetPage(
        name: Routes.candidateCalendar, page: () => CandidateCalendarView()),
    GetPage(name: Routes.declaration, page: () => const DeclarationView()),
    GetPage(name: Routes.ajouterPharmacie, page: () => const AjouterPharmacieView()),
    GetPage(name: Routes.basicExemple, page: () => const BasicExempleView()),
    GetPage(name: Routes.complexExemple, page: () => ComplexExempleView()),
    GetPage(
        name: Routes.detailFutureRecruiter,
        page: () => DetailFutureRecruiterView()),
    GetPage(
        name: Routes.detailNowRecruiter, page: () => DetailNowRecruiterView()),
    GetPage(
        name: Routes.detailPassRecruiter,
        page: () => DetailPassRecruiterView()),
    GetPage(name: Routes.description, page: () => const DescriptionView()),
    GetPage(
        name: Routes.DetailFutureCandidate,
        page: () => DetailFutureCandidateView()),
    GetPage(
        name: Routes.DetailNowCandidate, page: () => DetailNowCandidateView()),
    GetPage(
        name: Routes.DetailPassCandidate,
        page: () => DetailPassCandidateView()),
    GetPage(name: Routes.pharmacieInfo, page: () => const PharmacieInfoView()),
    GetPage(name: Routes.pharmacie, page: () => const PharmacieView()),
    GetPage(name: Routes.myRecruiter, page: () => const MyRecruiterView()),
    GetPage(name: Routes.ajouterPharmacie, page: () => const AjouterPharmacieView()),
    GetPage(
        name: Routes.recuAjouterPharmacieRoute,
        page: () => const RecuAjouterPharmacieView()),
    GetPage(name: Routes.demande, page: () => const DemandeView()),
    GetPage(name: Routes.demandeToPhar, page: () => const DemandeToPharView()),
    GetPage(name: Routes.homepagePhar, page: () => const HomepagePharView()),
    GetPage(
        name: Routes.candidateAvailability,
        page: () => const CandidateAvailabilityView()),
    GetPage(
        name: Routes.addCandidateAvailability,
        page: () => const AddCandidateAvailabilityView()),
    GetPage(
        name: Routes.ajouterMission, page: () => const AjouterMissionView()),
    GetPage(
        name: Routes.recruAvailability,
        page: () => const RecruAvailabilityView()),
    GetPage(
        name: Routes.editMyPharmacy, page: () => const EditMyPharmacyView()),
    GetPage(
        name: Routes.rDVFixeCandidate,
        page: () => const RDVFixeCandidateView()),
    GetPage(name: Routes.rDVFixeRecru, page: () => const RDVFixeRecruView()),
    GetPage(name: Routes.editAVLP, page: () => const EditAVLPView()),
    GetPage(name: Routes.editAVLU, page: () => const EditAVLUView()),
    GetPage(
        name: Routes.showUserCVtoPhar,
        page: () => const ShowUserCVtoPharView()),
  ];
}

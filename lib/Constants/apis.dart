const String baseUrl = 'http://tablet.panaceacloud.com:8220/ToplineApp';
//const String baseUrl = 'http://tablet.panaceacloud.com:8216/tencate';

const String loginAPI = "/api/MobileApp/AppDetails/Login";

const String registrationAPI =
    "/api/MobileApp/AppDetails/PatientRegistrationMobApps";
const String patientProfileApi =
    "/api/MobileApp/AppDetails/GetPatientDetails?id=";

const String doctorsAPI = "/api/MobileApp/AppDetails/getAllDoctors";

const String appointmentAPI =
    "/api/MobileApp/AppDetails/getPatientAppointments?id=";

const String bookingApi = '/api/MobileApp/AppDetails/BookAppointment';

const String cancelAppoinment = '/api/MobileApp/AppDetails/cancel_appointment';

const String updateAppoinment = '/api/MobileApp/AppDetails/update_appointment';

const String slotsApi = "/api/MobileApp/AppDetails/DoctorAvailableTimeslots";

const String pdfViewApi =
    "/api/MobileApp/AppDetails/GetLabAndRadiologyByPatientId?id=";

const String billingApi = "/api/MobileApp/AppDetails/GetAllBillByPatientId?id=";

const String patientHistorytAPI =
    "/api/MobileApp/AppDetails/GetRecentAppointemtByPatientId?id=";

const String proceduresApi =
    "/api/MobileApp/AppDetails/GetAllTreatmentByPatientId?id=";

const String forgotpassword =
    "/api/MobileApp/AppDetails/GetPatientPassword?email=";

const String resetPass="/api/MobileApp/AppDetails/ResetPassword" ;

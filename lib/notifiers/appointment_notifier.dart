import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vms/data/appointment_statuses.dart';
import 'package:vms/data/floors.dart';
import 'package:vms/data/group_heads.dart';
import 'package:vms/data/locations.dart';
import 'package:vms/data/time_selection.dart';
import 'package:vms/data/visit_types.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/helperfunctions/custom_string_manipulations.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/models/fetched_appointments.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/models/user.dart';
import 'package:vms/models/visitor.dart';
import 'package:vms/notifiers/user_notifier.dart';

import '../models/location.dart';

class AppointmentNotifier with ChangeNotifier {
  List<Appointment> _appointmentsList = [];

  bool _completed = false;
  bool _isCreating = false;
  bool _isEditing = false;
  Visitor _newGuest = Visitor.emptyOne();

  Map<String, String> newAppointmentErrors = {};
  Map<String, String> locationErrors = {};
  Map<String, String> visitorInformationErrors = {};
  Map<String, String> currentGuestErrors = {};
  Map<String, String> otherVisitorInformationErrors = {};

  List<Appointment> get appointments {
    return [..._appointmentsList];
  }

  Map<String, String> get allNewAppointmentErrors {
    return {...newAppointmentErrors};
  }

  Map<String, String> get allLocationErrors {
    return {...locationErrors};
  }

  Map<String, String> get allVisitorInformationErrors {
    return {...visitorInformationErrors};
  }

  Map<String, String> get allCurrentGuestErrors {
    return {...currentGuestErrors};
  }

  Map<String, String> get allOtherVisitorInformationErrors {
    return {...otherVisitorInformationErrors};
  }

  bool get isCreating => _isCreating;
  bool get isEditing => _isEditing;

  Visitor get getNewGuest {
    return _newGuest;
  }

  set setIsCreating(bool isCreating) {
    //remove all errors
    removeAllErrors();
    _isCreating = isCreating;
  }

  set setIsEditing(bool isEditing) {
    //remove all errors
    removeAllErrors();
    _isEditing = isEditing;
  }

  set setNewGuest(Visitor visitor) {
    _newGuest = visitor;
    notifyListeners();
  }

  void removeAllErrors() {
    newAppointmentErrors = {};
    locationErrors = {};
    visitorInformationErrors = {};
    otherVisitorInformationErrors = {};
  }

  set completed(bool completed) {
    _completed = completed;
    notifyListeners();
  }

  void resetAppointmentList() {
    _appointmentsList.clear();
    _newGuest = Visitor.emptyOne();
  }

  void loadSelectedAppointment(FetchedAppointments? fetchedAppointments) {
    setIsEditing = true;
    setIsCreating = false;
    if (fetchedAppointments != null) {
      Appointment appointment = Appointment(
        id: fetchedAppointments.appointmentId.toString(),
        host: fetchedAppointments.host,
        visitorType: fetchedAppointments.visitors.length > 0
            ? (fetchedAppointments.visitors[0].visitorType ?? "")
            : "",
        visitPurpose: fetchedAppointments.visitPurpose,
        startTime: fetchedAppointments.startTime,
        groupHead: fetchedAppointments.groupHead,
        endTime: fetchedAppointments.endTime,
        visitType: "",
        appointmentStatus: 0,
        appointmentDate: fetchedAppointments.appointmentDate,
        floor: Floor.emptyOne(),
        guests: [],
        meetingRoom: '',
        rooms: [],
        location: Location.emptyOne(),
        purposeOfCancel: "",
        purposeOfReschedule: "",
      );
      resetAppointmentList();
      _appointmentsList.add(appointment);
      showAppointment(appointment);
      notifyListeners();
    }
  }

  void addEmptyAppointment() {
    if (!isCreating) {
      resetAppointmentList();

      _appointmentsList.add(
        new Appointment(
          id: "",
          host: Host.emptyOne(),
          visitPurpose: "",
          startTime: CustomDateFormatter.getDateTimeFromTimeString(
              DateTime.now(), timesSelection[0]),
          endTime: CustomDateFormatter.getDateTimeFromTimeString(
              DateTime.now(), timesSelection[1]),
          visitType: "",
          visitorType: "",
          appointmentStatus: 0, //appointmentStatuses[0]["value"],
          appointmentDate: DateTime.now(),
          floor: Floor.emptyOne(),
          guests: [getNewGuest],
          rooms: [],
          meetingRoom: "",
          location: Location.emptyOne(),
          groupHead: GroupHead.emptyOne(),
          purposeOfReschedule: "",
          purposeOfCancel: "",
        ),
      );
      setIsCreating = true;
    }
  }

  void addGuests(List<dynamic> guests) {
    _appointmentsList[_appointmentsList.length - 1].guests = guests;
  }

  List<dynamic> getValidGuests() {
    var allGuests = _appointmentsList[_appointmentsList.length - 1].guests;
    try {
      var validGuests = allGuests.where((element) => element.isValid());
      addGuests(validGuests.toList());
      return validGuests.toList();
    } on StateError {
      print("There was an error getting valid guests");
    }

    notifyListeners();
    return allGuests;
  }

  void createEmptyGuest() {
    setNewGuest = Visitor.emptyOne();
    notifyListeners();
  }

  void addGuest(Visitor visitor) {
    appointments[appointments.length - 1].guests.add(visitor);
    print("Added new guest");
    showAppointment(appointments[appointments.length - 1]);
    notifyListeners();
  }

  void addVisitorType(String visitorType) {
    _appointmentsList[_appointmentsList.length - 1].visitorType = visitorType;
    notifyListeners();
  }

  void addGroupHead(GroupHead groupHead) {
    _appointmentsList[_appointmentsList.length - 1].groupHead = groupHead;
    notifyListeners();
  }

  void addVisitPurpose(String visitPurpose) {
    _appointmentsList[_appointmentsList.length - 1].visitPurpose = visitPurpose;
    notifyListeners();
  }

  void addHost(Host host) {
    _appointmentsList[_appointmentsList.length - 1].host = host;
    notifyListeners();
  }

  void addMeetingRoom(String meetingRoom) {
    _appointmentsList[_appointmentsList.length - 1].meetingRoom = meetingRoom;
    notifyListeners();
  }

  void addVisitorId(Visitor visitor, int id) {
    var curGuest = getNewGuest;
    curGuest.id = id;
    setNewGuest = curGuest;
    // showAppointment(_appointmentsList[_appointmentsList.length - 1]);
    notifyListeners();
  }

  void addVisitorFirstName(String firstName) {
    var curGuest = getNewGuest;
    curGuest.firstName = firstName;
    setNewGuest = curGuest;
    // showAppointment(_appointmentsList[_appointmentsList.length - 1]);
    notifyListeners();
  }

  void addVisitorLastName(String lastName) {
    var curGuest = getNewGuest;
    curGuest.lastName = lastName;
    setNewGuest = curGuest;
    // showAppointment(_appointmentsList[_appointmentsList.length - 1]);
    notifyListeners();
  }

  void addVisitorEmail(String email) {
    var curGuest = getNewGuest;
    curGuest.email = email;
    setNewGuest = curGuest;
    // showAppointment(_appointmentsList[_appointmentsList.length - 1]);
    notifyListeners();
  }

  void addVisitorAddress(String address) {
    var curGuest = getNewGuest;
    curGuest.address = address;
    setNewGuest = curGuest;
    // showAppointment(_appointmentsList[_appointmentsList.length - 1]);
    notifyListeners();
  }

  void addVisitorPhoneNumber(String phoneNumber) {
    var curGuest = getNewGuest;
    curGuest.phoneNumber = phoneNumber;
    setNewGuest = curGuest;
    // showAppointment(_appointmentsList[_appointmentsList.length - 1]);
    notifyListeners();
  }

  void addStartTime(String startTime) {
    _appointmentsList[_appointmentsList.length - 1].startTime =
        CustomDateFormatter.getDateTimeFromTimeString(
            _appointmentsList[_appointmentsList.length - 1].appointmentDate,
            startTime);
    notifyListeners();
  }

  void addEndTime(String endTime) {
    _appointmentsList[_appointmentsList.length - 1].endTime =
        CustomDateFormatter.getDateTimeFromTimeString(
            _appointmentsList[_appointmentsList.length - 1].appointmentDate,
            endTime);
    notifyListeners();
  }

  void addAppointmentDate(DateTime appointmentDate) {
    _appointmentsList[_appointmentsList.length - 1].appointmentDate =
        appointmentDate;
    _appointmentsList[_appointmentsList.length - 1].startTime =
        CustomDateFormatter.getDateTimeFromTimeString(
            appointmentDate,
            CustomDateFormatter.getTimeStringFromDateTime(
                _appointmentsList[_appointmentsList.length - 1].startTime));
    _appointmentsList[_appointmentsList.length - 1].endTime =
        CustomDateFormatter.getDateTimeFromTimeString(
            appointmentDate,
            CustomDateFormatter.getTimeStringFromDateTime(
                _appointmentsList[_appointmentsList.length - 1].endTime));

    notifyListeners();
  }

  void addLocation(Location location) {
    _appointmentsList[_appointmentsList.length - 1].location = location;
    addFloor(location.floors[0]);
    print("floor: " +
        _appointmentsList[_appointmentsList.length - 1].floor.name.toString());
    notifyListeners();
  }

  void addRoom(Room room) {
    var existingRooms = _appointmentsList[_appointmentsList.length - 1].rooms;
    var r =
        existingRooms.firstWhere((_) => room.id == _.id, orElse: () => null);

    if (r != null) {
      _appointmentsList[_appointmentsList.length - 1].rooms.remove(r);
    } else {
      if (existingRooms.length < 3) {
        _appointmentsList[_appointmentsList.length - 1].rooms.add(room);
      }
    }

    notifyListeners();
  }

  void addRooms(List<dynamic> rooms) {
    _appointmentsList[_appointmentsList.length - 1].rooms = rooms;
    notifyListeners();
  }

  void addAppointment(Appointment appointment) {
    _appointmentsList.add(appointment);
    notifyListeners();
  }

  void addFloor(Floor floor) {
    _appointmentsList[_appointmentsList.length - 1].floor = floor;
    notifyListeners();
  }

  void addPurposeOfReschedule(String purposeOfReschedule) {
    _appointmentsList[_appointmentsList.length - 1].purposeOfReschedule =
        purposeOfReschedule;
    notifyListeners();
  }

  void addPurposeOfCancel(String purposeOfCancel) {
    _appointmentsList[_appointmentsList.length - 1].purposeOfCancel =
        purposeOfCancel;
    notifyListeners();
  }

  void showAppointment(Appointment appointment) {
    var app = "";
    app += "appointment id: " + appointment.id.toString() + "\n";
    app += "appointment date: " + appointment.appointmentDate.toString() + "\n";
    app += "room: " + appointment.rooms.toString() + "\n";
    app += "host: " + appointment.host.toString() + "\n";
    app += "visit purpose: " + appointment.visitPurpose.toString() + "\n";
    app += "end time: " + appointment.endTime.toString() + "\n";
    app += "start time: " + appointment.startTime.toString() + "\n";

    app += "guests: " + appointment.guests.toString() + "\n";
    app += "group head: " + appointment.groupHead.toString() + "\n";
    app += "visit type: " + appointment.visitType.toString() + "\n";
    app += "reschedule reason: " +
        appointment.purposeOfReschedule.toString() +
        "\n";
    app += "cancel reason: " + appointment.purposeOfCancel.toString() + "\n";
    app += "location: " + appointment.location.toString() + "\n";
    app += "floor: " + appointment.floor.toString() + "\n";

    print(app);
  }

  void removeLastGuest() {
    var allGuests = _appointmentsList[_appointmentsList.length - 1].guests;
    var lastGuest = allGuests[allGuests.length - 1];
    if (!lastGuest.isValid()) {
      _appointmentsList[_appointmentsList.length - 1].guests.removeLast();
      notifyListeners();
    }
  }

  //Register errors to be removed
  void removeError(String errorType) {
    newAppointmentErrors.remove(errorType);
    locationErrors.remove(errorType);
    visitorInformationErrors.remove(errorType);
    currentGuestErrors.remove(errorType);
    otherVisitorInformationErrors.remove(errorType);
    notifyListeners();
  }

  bool dateDayIsInValid(DateTime date) {
    if (date != null && date != "") {
      if (DateFormat('EEEE').format(date).toString().toLowerCase() ==
              "sunday" ||
          DateFormat('EEEE').format(date).toString().toLowerCase() ==
              "saturday") {
        return true;
      }
      return false;
    }
    return false;
  }

  void isAppointmentDateValid(DateTime appointmentDate) {
    if (appointmentDate == null ||
        appointmentDate == "" ||
        dateDayIsInValid(appointmentDate)) {
      newAppointmentErrors.putIfAbsent(
          "appointmentDate", () => "Please select a valid date");
    } else {
      newAppointmentErrors.remove("appointmentDate");
    }
  }

  void isVisitorTypeValid(String visitorType) {
    if (visitorType == null || visitorType == "") {
      newAppointmentErrors.putIfAbsent(
          "visitType", () => "Please select a visitor type");
    } else {
      newAppointmentErrors.remove("visitorType");
    }
  }

  void isVisitPurposeValid(String visitPurpose) {
    if (visitPurpose == null || visitPurpose == "") {
      newAppointmentErrors.putIfAbsent(
          "visitPurpose", () => "Please select a visit type");
    } else {
      newAppointmentErrors.remove("visitPurpose");
    }
  }

  void isHostValid(Host host) {
    if (!host.isValid()) {
      newAppointmentErrors.putIfAbsent("host", () => "Please select a host");
    } else {
      newAppointmentErrors.remove("host");
    }
  }

  void isGroupHeadValid(GroupHead groupHead) {
    if (!groupHead.isValid()) {
      newAppointmentErrors.putIfAbsent(
          "groupHead", () => "Please select a group head");
    } else {
      newAppointmentErrors.remove("groupHead");
    }
  }

  void isStartTimeValid(DateTime startTime) {
    if (startTime == null ||
        startTime == "" ||
        startTime.isBefore(DateTime.now()) ||
        startTime.isAtSameMomentAs(DateTime.now())) {
      newAppointmentErrors.putIfAbsent("startTime", () => "Invalid start time");
    } else {
      newAppointmentErrors.remove("startTime");
    }
  }

  void isEndTimeValid(DateTime endTime, DateTime startTime) {
    if (endTime == null ||
        endTime == "" ||
        endTime.isBefore(DateTime.now()) ||
        endTime.isAtSameMomentAs(startTime) ||
        endTime.isBefore(startTime)) {
      newAppointmentErrors.putIfAbsent("endTime", () => "Invalid end time");
    } else {
      newAppointmentErrors.remove("endTime");
    }
  }

  void newAppointmentValid() {
    var currentAppointment = _appointmentsList[_appointmentsList.length - 1];

    isVisitorTypeValid(currentAppointment.visitorType);
    isAppointmentDateValid(currentAppointment.appointmentDate);
    isVisitPurposeValid(currentAppointment.visitPurpose);
    isHostValid(currentAppointment.host);
    isGroupHeadValid(currentAppointment.groupHead);
    isStartTimeValid(currentAppointment.startTime);
    isEndTimeValid(currentAppointment.endTime, currentAppointment.startTime);

    print(newAppointmentErrors);

    notifyListeners();
  }

  void isLocationValid(Location location) {
    if (!location.isValid()) {
      locationErrors.putIfAbsent("location", () => "Please select a location");
    } else {
      locationErrors.remove("location");
    }
  }

  void isFloorValid(Floor floor) {
    if (floor == null || floor == "") {
      locationErrors.putIfAbsent("floor", () => "Please select a floor");
    } else {
      locationErrors.remove("floor");
    }
  }

  void isMeetingRoomValid(String meetingRoom) {
    if (meetingRoom == null || meetingRoom == "") {
      locationErrors.putIfAbsent("meetingRoom", () => "Please enter a room");
    } else {
      locationErrors.remove("meetingRoom");
    }
  }

  void areRoomsValid(List<dynamic> rooms) {
    if (rooms == null || rooms.isEmpty) {
      locationErrors.putIfAbsent(
          "rooms", () => "Please select at least one room");
    } else {
      locationErrors.remove("rooms");
    }
  }

  void locationValid() {
    var currentAppointment = _appointmentsList[_appointmentsList.length - 1];

    isLocationValid(currentAppointment.location);
    isFloorValid(currentAppointment.floor);
    // isMeetingRoomValid(currentAppointment.meetingRoom);
    areRoomsValid(currentAppointment.rooms);

    print(locationErrors);

    notifyListeners();
  }

  void isGuestEmailValid(String email, Map<String, String> errorsType) {
    if (email == null || email == "") {
      errorsType.putIfAbsent("email", () => "Please enter email");
    } else {
      errorsType.remove("email");
    }
    if (!CustomStringManipulation.validatEmail(email)) {
      errorsType.putIfAbsent("email", () => "Please enter valid email");
    } else {
      errorsType.remove("email");
    }
  }

  void isGuestPhoneNumberValid(
      String phoneNumber, Map<String, String> errorsType) {
    if (phoneNumber == null || phoneNumber == "") {
      errorsType.putIfAbsent("phoneNumber", () => "Please enter phone number");
    } else {
      errorsType.remove("phoneNumber");
    }
    if (!CustomStringManipulation.validatPhoneNumber(phoneNumber)) {
      errorsType.putIfAbsent(
          "phoneNumber", () => "Please enter valid phone number");
    } else {
      errorsType.remove("phoneNumber");
    }
  }

  void isGuestAddressValid(String address, Map<String, String> errorsType) {
    if (address == null || address == "") {
      errorsType.putIfAbsent("address", () => "Please enter address");
    } else {
      errorsType.remove("address");
    }
  }

  void isGuestFirstNameValid(String firstName, Map<String, String> errorsType) {
    if (firstName == null || firstName == "") {
      errorsType.putIfAbsent("firstName", () => "Please enter first name");
    } else {
      errorsType.remove("firstName");
    }
  }

  void isGuestLastNameValid(String lastName, Map<String, String> errorsType) {
    if (lastName == null || lastName == "") {
      errorsType.putIfAbsent("lastName", () => "Please enter last name");
    } else {
      errorsType.remove("lastName");
    }
  }

  void otherGuestInformationValid() {
    var currentAppointment = _appointmentsList[_appointmentsList.length - 1];
    var currentGuests = currentAppointment.guests;
    var currentGuest = currentGuests[currentGuests.length - 1];

    isGuestEmailValid(currentGuest.email, otherVisitorInformationErrors);

    isGuestPhoneNumberValid(
        currentGuest.phoneNumber, otherVisitorInformationErrors);

    print("other visitor information errors: " +
        otherVisitorInformationErrors.toString());

    notifyListeners();
  }

  void currentGuestValid() {
    var currentGuest = getNewGuest;
    isGuestFirstNameValid(currentGuest.firstName, currentGuestErrors);
    isGuestLastNameValid(currentGuest.lastName, currentGuestErrors);
    isGuestEmailValid(currentGuest.email, currentGuestErrors);
    isGuestPhoneNumberValid(currentGuest.phoneNumber, currentGuestErrors);

    isGuestAddressValid(currentGuest.address, currentGuestErrors);

    print(currentGuestErrors);

    notifyListeners();
  }

  void visitorInformationValid() {
    var currentAppointment = _appointmentsList[_appointmentsList.length - 1];
    var currentGuests = currentAppointment.guests;
    isGuestFirstNameValid(currentGuests[currentGuests.length - 1].firstName,
        visitorInformationErrors);
    isGuestLastNameValid(currentGuests[currentGuests.length - 1].lastName,
        visitorInformationErrors);
    isGuestEmailValid(currentGuests[currentGuests.length - 1].email,
        visitorInformationErrors);
    isGuestPhoneNumberValid(currentGuests[currentGuests.length - 1].phoneNumber,
        visitorInformationErrors);

    isGuestAddressValid(currentGuests[currentGuests.length - 1].address,
        visitorInformationErrors);

    print(visitorInformationErrors);

    notifyListeners();
  }

  void isPurposeOfCancelValid(
      String purposeOfCancel, Map<String, String> errorsType) {
    if (purposeOfCancel == null || purposeOfCancel == "") {
      errorsType.putIfAbsent(
          "purposeOfCancel", () => "Please select/input a purpose of cancel");
    } else {
      errorsType.remove("purposeOfCancel");
    }
  }

  void isCancelValid() {
    var currentAppointment = _appointmentsList[_appointmentsList.length - 1];
    isPurposeOfCancelValid(
        currentAppointment.purposeOfCancel ?? "", newAppointmentErrors);
    notifyListeners();
  }

  void isRescheduleValid() {
    var currentAppointment = _appointmentsList[_appointmentsList.length - 1];
    isAppointmentDateValid(currentAppointment.appointmentDate);
    isStartTimeValid(currentAppointment.startTime);
    isEndTimeValid(currentAppointment.endTime, currentAppointment.startTime);
    notifyListeners();
  }

  static List<Appointment> getPendingAppointmentRequests(
      List<Appointment> appointmentRequests) {
    try {
      var ar = appointmentRequests
          .where((element) => element.appointmentStatus == PENDING)
          .toList();

      return ar;
    } on StateError {
      return [];
    }
  }

  static int getAppointmentStatusFromName(
      String name, List<Map<String, dynamic>> statuses) {
    try {
      var as = statuses.firstWhere((element) {
        return element["name"].toLowerCase() == name.toLowerCase();
      });
      return as["value"];
    } on StateError {
      return 0;
    }
  }

  static List<FetchedAppointments> fetchAppointmentForDay(
      List<FetchedAppointments> appointments, DateTime selectedDate) {
    String selectedDateString =
        CustomDateFormatter.getFormatedDate(selectedDate);
    try {
      var ar = appointments
          .where((element) =>
              CustomDateFormatter.getFormatedDate(element.appointmentDate) ==
              selectedDateString)
          .toList();
      return ar;
    } on StateError {
      return [];
    }
  }

  static List<DateTime> getMarkedDates(List<FetchedAppointments> appointments) {
    try {
      var md = appointments.map((element) => element.appointmentDate).toList();
      return md;
    } on StateError {
      return [];
    }
  }
}

# Add Network and API Client to Core

This plan outlines the steps to integrate a robust networking layer and API client into the `core` section of the project, following Clean Architecture principles.

## User Review Required

> [!IMPORTANT]
> I will be adding `dio` and `internet_connection_checker` to `pubspec.yaml`. Please ensure you have an active internet connection to fetch these packages after I update the file.

## Proposed Changes

### Dependencies

#### [MODIFY] [pubspec.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/pubspec.yaml)
- Add `dio: ^5.7.0`
- Add `internet_connection_checker: ^3.0.1`

### Core Network

#### [NEW] [network_info.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/core/network/network_info.dart)
- Define `NetworkInfo` abstract class with `isConnected` getter.
- Implement `NetworkInfoImpl` using `internet_connection_checker`.

### Core API

#### [NEW] [api_client.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/core/api/api_client.dart)
- Define a base `DioClient` with common configurations (base URL, timeouts, interceptors).

#### [NEW] [api_endpoints.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/core/api/api_endpoints.dart)
- Store API constants and endpoints.

#### [NEW] [api_interceptors.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/core/api/api_interceptors.dart)
- Add common interceptors (logging, headers).

### Dependency Injection

#### [MODIFY] [injection_container.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/injection_container.dart)
- Register `Dio`, `InternetConnectionChecker`, `NetworkInfo`, and `DioClient`.

## Verification Plan

### Automated Tests
- I will verify the code compiles.
- Since this is adding infrastructure, I will check that the classes can be instantiated via `GetIt`.

### Manual Verification
- N/A (Infrastructure setup)

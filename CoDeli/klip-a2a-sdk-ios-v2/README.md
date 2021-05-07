# Klip iOS SDK
Klip iOS SDK는 Klip을 이용하여 iOS 플랫폼 위에서 BApp을 만들 수 있도록 제공하는 프레임워크입니다.

## Environment/Prerequisites
### 요구사항
    - Swift 4 이상
    - iOS 11.0 이상
    - Xcode 11.7 이상

### 환경 설정
**Info.plist 앱 실행 허용 목록(Allowlist) 등록하기**

iOS 9.0 이상에서 iOS SDK를 통해 카카오톡 등 애플리케이션(이하 앱)을 실행시키는 기능을 이용하려면 Info.plist 파일에 설정을 추가하여 커스텀 스킴 정보를 등록해주어야합니다.

[Info] > [Custom iOS Target Properties]에 Array 타입 키(Key)인 LSApplicationQueriesSchemes를 추가하고, 해당 키의 'Item'으로 커스텀스킴에 사용할 값인 'kakaotalk', 'itms-apps'를 추가합니다.
```xml
 	<key>LSApplicationQueriesSchemes</key>
 	<array>
 		<string>kakaotalk</string>
 		<string>itms-apps</string>
 	</array>
```

## SDK Build/Install

[다운로드](http://docs.klipwallet.com/a2a-sdk/a2a-sdk-download) 페이지에서 Klip iOS SDK를 다운받습니다.
### Klip SDK Framework를 Import하여 개발 프로젝트에 추가
1. 개발 중인 프로젝트를 **Xcode**로 실행
2. **Xcode > 개발 프로젝트의 TARGETS 선택 > General Tab > Framworks, Libraries, and Embedded Content Tab > 왼쪽 하단의 + 버튼**을 클릭
3. **Source Directory**에 다운받은 Klip SDK 프로젝트의 **sdk** 디렉토리를 선택, 클릭한 후 **Next**를 클릭
4. 왼쪽의 Project navigator의 Frameworks에 해당 SDK가 Import 되었는지 확인 후 build 수행

Klip SDK 소스가 개발 프로젝트에 복사되고 라이브러리 코드를 직접 수정할 수 있습니다.

# Sample Application Run
Sample Application 실행 후, 아래의 5가지 따라하기로 실행이 가능합니다.
- [따라하기 1] Klip 사용자 인증 정보(ex, Klaytn Address) 가져오기
- [따라하기 2] Klip 사용자 KLAY 전송하기
- [따라하기 3] Klip 사용자 Token 전송하기
- [따라하기 4] Klip 사용자 Card 전송하기
- [따라하기 5] Klip 사용자 Contract 실행하기
- [따라하기 6] Klip 처리 상태 확인하기

## 따라하기 1. Klip 사용자 인증 정보 가져오기
### 순서
1. "Prepare Link" 버튼 클릭
    - BApp Name : Klip 화면에 출력될 BApp Name 입력
    - BApp Success URL : (optional) Klip 실행 성공 후, 이동될 URL 입력
    - BApp Fail URL : (optional) Klip 실행 실패 후, 이동될 URL 입력
    - "Ok" 버튼 클릭
2. 메인 화면으로 복귀 후 "current requestKey" label 하단에 값이 잘 들어왔는지 확인
3. "request" 버튼 클릭
4. (Klip 화면 이동 후) "확인" 버튼 클릭
5. (샘플 화면 이동 후) "Get Result" 버튼 클릭

## 따라하기 2. Klip 사용자 KLAY 전송하기
### 주의
KLAY 전송에 사용되는 Value 값의 기본 단위는 KLAY입니다. 예를 들어, 1 KLAY 전송을 시도한다면 1 입력해야 합니다.

### 순서
1. "Prepare Send KLAY" 버튼 클릭
    - To Address : KLAY 전송받을 사용자 Klaytn Address 입력
    - From Address : (optional) KLAY 전송시킬 사용자 Klaytn Address 입력
    - Value : KLAY 전송량 입력
    - BApp Name : Klip 화면에 출력될 BApp Name 입력
    - BApp Success URL : (optional) Klip 실행 성공 후, 이동될 URL 입력
    - BApp Fail URL : (optional) Klip 실행 실패 후, 이동될 URL 입력
    - "Ok" 버튼 클릭
2. (메인 화면으로 복귀 후) "current requestKey" label 하단에 값이 잘 들어왔는지 확인
3. "request" 버튼 클릭
4. (Klip 화면 이동 후) "확인" 버튼 클릭
5. (샘플 화면 이동 후) "Get Result" 버튼 클릭

## 따라하기 3. Klip 사용자 Token 전송하기
### 순서
1. "Prepare Send Token" 버튼 클릭
    - Contract Address : 전송할 Token Contract Address 입력
    - To Address : Token 전송받을 사용자 Klaytn Address 입력
    - From Address : (optional) KLAY 전송시킬 사용자 Klaytn Address 입력
    - Amount : Token 전송량 입력
    - BApp Name : Klip 화면에 출력될 BApp Name 입력
    - BApp Success URL : (optional) Klip 실행 성공 후, 이동될 URL 입력
    - BApp Fail URL : (optional) Klip 실행 실패 후, 이동될 URL 입력
    - "Ok" 버튼 클릭
2. (메인 화면으로 복귀 후) "current requestKey" label 하단에 값이 잘 들어왔는지 확인
3. "request" 버튼 클릭
4. (Klip 화면 이동 후) "확인" 버튼 클릭
5. (샘플 화면 이동 후) "Get Result" 버튼 클릭

## 따라하기 4. Klip 사용자 Card 전송하기
### 순서 
- 전송하려는 사용자의 Card ID를 이미 알고 있을 경우, 아래 순서의 1번과 2번은 생략이 가능합니다. 
- Sample Application은 1번과 2번 과정을 순서대로 수행할 경우, 3번 과정에서 필요한 Card ID값이 자동으로 세팅되도록 개발되었습니다.

1. (optional) [따라하기 1] 수행해서 사용자의 Klaytn Address 가져오기
2. (optional) "Get Card List" 버튼 클릭
    - Card Address : 조회할 Card Contract Address 입력
    - User Address : 조회할 User Klaytn Address 입력
    - Cursor : 조회 Card 내용이 100개가 넘어갈 경우 다음 Cursor 입력
3. "Prepare Send Card" 버튼 클릭
    - Contract Address : 전송할 Card Contract Address 입력
    - To Address : Card 전송받을 사용자 Klaytn Address 입력
    - From Address : (optional) KLAY 전송시킬 사용자 Klaytn Address 입력
    - Card ID : 전송할 Card Id 입력
    - BApp Name : Klip 화면에 출력될 BApp Name 입력
    - BApp Success URL : (optional) Klip 실행 성공 후, 이동될 URL 입력
    - BApp Fail URL : (optional) Klip 실행 실패 후, 이동될 URL 입력
    - "Ok" 버튼 클릭
4. (메인 화면으로 복귀 후) "current requestKey" label 하단에 값이 잘 들어왔는지 확인
5. "request" 버튼 클릭
6. (Klip 화면 이동 후) "확인" 버튼 클릭
7. (샘플 화면 이동 후) "Get Result" 버튼 클릭

## 따라하기 5. Klip 사용자 Contract 실행하기
### 주의
- Contract 실행에 사용되는 Value 값의 기본 단위는 peb입니다. 예를 들어, 1 KLAY 전송을 시도한다면 1000000000000000000 입력해야 합니다. Klaytn에서 사용되는 KLAY 단위는 Klaytn Document > KLAY 단위를 참고할 수 있습니다.
- Contract 실행에 사용되는 ABI와 Params의 개수와 타입은 동일해야 합니다. 예를 들어, inputs에 포함된 내용이 3개라면 params에 포함된 내용이 3개이어야 합니다.
- Contract 실행에 사용되는 ABI는 실행할 Method 부분만을 발췌하여 "{..}" 형태로 입력되어야 합니다.
- Contract 실행에 사용되는 Params는 ABI에 입력된 inputs과 동일한 순서로 "[..]" 형태로 입력되어야 합니다.

### 순서
1. "Prepare Contract Execution" 버튼 클릭
    - To Contract Address : 실행할 Contract address 입력
    - From Address : (optional) KLAY 전송시킬 사용자 Klaytn Address 입력
    - Value : KLAY 전송량 입력
    - ABI : 실행할 Contract의 Method에 대한 ABI 입력
        
        ex)
        ```
        {"constant":false,"inputs":[{"name":"from","type":"address"},{"name":"to","type":"address"},{"name":"tokenId","type":"uint256"}],"name":"safeTransferFrom","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}
        ```
    - Params : 실행할 Contract의 Method에 대한 Params 입력
        
        ex) 
        ```
        ["0x120E120bB50fD36847FA93197217d956b6ad1E93", "0x2d9aea5038ca7efac0ebe1b627104c7ece1a3d1a", 1]
        ```
    - BApp Name : Klip 화면에 출력될 BApp Name 입력
    - BApp Success URL : (optional) Klip 실행 성공 후, 이동될 URL 입력
    - BApp Fail URL : (optional) Klip 실행 실패 후, 이동될 URL 입력
    - "Ok" 버튼 클릭
2. (메인 화면으로 복귀 후) "current requestKey" label 하단에 값이 잘 들어왔는지 확인
3. "request" 버튼 클릭
4. (Klip 화면 이동 후) "확인" 버튼 클릭
5. (샘플 화면 이동 후) "Get Result" 버튼 클릭

## 따라하기 6. Klip 처리 상태 확인하기
### 주의
- 사용자 승인이 완료되었지만, Transaction 처리가 실패되었다면, 실패가 나는 경우가 발생할 수 있습니다.
- 예를 들면, [따라하기 5]를 통해 Contract 실행을 했지만, 해당 Contract 내부에서 에러가 발생하여 Revert가 일어난 경우가 있을 수 있습니다.
- 만약 Revert로 실패가 나는 경우, 응답 결과로 받은 "tx_hash"값을 Klayn Scope로 조회함으로써 Revert 여부를 직접 확인할 수 있습니다.

### 순서 
Sample Application은 [따라하기 1~5]과정을 수행할 경우, 2번 과정에서 필요한 Request Key값이 자동으로 세팅되어 동작하도록 개발되었습니다.

1. [따라하기 1~5] 수행
2. "Get Result" 버튼 클릭

# Directory Structure
```
project
├── KlipSDK/
|   |--KlipSDK/
|   |  |--API
|   |  |--Extension
|   |  |--Network
|   |  |--klip_sdk.h
|   |  |--Info.plist
|   |--KlipSDK-Sample
|   |--KlipSDK.xcodeproj
```

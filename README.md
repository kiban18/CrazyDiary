# CrazyDiary

## 설치
`git clone https://github.com/kiban18/CrazyDiary.git`

CrazyDiary는 일기장 앱 입니다.

앱의 주요 기능을 다음과 같은 순서로 개발할 예정입니다.

1. 일기를 작성하고, 작성한 일기를 열람하는 화면 등을 구현
2. 작성한 데이터가 사라지지 않도록 CoreData 및 Realm을 이용한 영속성 구현
3. 앱 제거후 재설치를 해도 데이터를 계속 유지할 수 있도록 네트워킹을 통한 서버 통신 구현
4. 계정 기능과 Facebook, KakaoTalk, Twitter 소셜 로그인 구현
5. 로그인 화면에 애니메이션 및 트랜지션 적용
6. RxSwift를 이용해 비동기 코드 대체
7. 기존 구현된 MVC 패턴의 아키텍처를 RxSwift를 적용한 RxMVVM 패턴으로 대체

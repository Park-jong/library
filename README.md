# 도서관 관리 시스템

## 사용언어 및 실행환경
* html5
* css3
* javascript
* jsp2.3
* Apache Tomcat/9.0.46

## ER Diagram
<image src='https://user-images.githubusercontent.com/54964209/187164836-9b897864-5ea2-492e-bf56-a501b258aac8.png'>

## 동작 소개
### 도서 검색
#### 기본 화면
<image src="https://user-images.githubusercontent.com/54964209/187371619-5d4363a7-d9d1-47e3-88b7-d0dd820f3dc5.png">
<image src="https://user-images.githubusercontent.com/54964209/187372230-95874651-764a-4e7f-a236-0a58a849f2d0.png">
<image src="https://user-images.githubusercontent.com/54964209/187371655-7cd9d2b8-edc9-404b-a512-c73bd10edda0.png">

#### 도서명, 저자, 출판사로 검색 가능  
  
<image src="https://user-images.githubusercontent.com/54964209/187371659-0c0ae84d-8f6e-487f-b5b7-bec9b44aac01.png">
<image src="https://user-images.githubusercontent.com/54964209/187371672-f76b1544-db87-4d95-aa1c-c030e4f7dfe0.png">

#### AND, OR 연산을 통해 추가 검색 가능

* AND, OR의 연산 순서는 우선순위 없이 (A · B) · C로 연산
### 도서 대출
<image src="https://user-images.githubusercontent.com/54964209/187377452-f8e9a90a-c07b-439f-9ee0-3481074fc8bd.png">
<image src="https://user-images.githubusercontent.com/54964209/187377463-e973ba40-260d-4269-bef0-d8d21b1fbc30.png">

#### 검색 화면에서 대출 가능 상태의 목록을 클릭하거나 대출 창에서 도서 등록 번호를 입력 시 대출 가능
* 로그인 상태에서만 이용 가능
* 이미 대출 중인 도서 대출 불가

### 대출 연장
<image src="https://user-images.githubusercontent.com/54964209/187379375-bfaa9112-66b9-49ff-9845-b60a0135c09b.png">
<image src="https://user-images.githubusercontent.com/54964209/187379393-dff4d387-7721-4cd9-a8e7-1ad98f806722.png">
#### 대출 중인 도서 대출 기간 연장
* 로그인 상태에서만 이용 가능
* 최대 3번 가능
* 이미 기간을 지났을 경우 연장 불가

### 도서 예약
### 예약 취소
### 도서 반납
### 대출 기록

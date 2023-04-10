# 도서관 관리 시스템

## 사용언어 및 실행환경
* html5
* css3
* javascript
* jsp2.3
* Apache Tomcat/9.0.46

## 진행 날짜
* 2021.06 ~ 2021.06

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
* 회원 당 동시에 3권까지 대출 가능

### 대출 연장
<image src="https://user-images.githubusercontent.com/54964209/187379375-bfaa9112-66b9-49ff-9845-b60a0135c09b.png">
<image src="https://user-images.githubusercontent.com/54964209/187379393-dff4d387-7721-4cd9-a8e7-1ad98f806722.png">
  
#### 대출 중인 도서 대출 기간 연장   
* 로그인 상태에서만 이용 가능   
* 최대 3번 가능   
* 이미 기간을 지났을 경우 연장 불가

### 도서 예약
<image src="https://user-images.githubusercontent.com/54964209/187381098-63fe4b69-11a1-4632-b256-08c46b395eb2.png">

#### 대출 중인 도서 예약
* 로그인 상태에서만 이용 가능
* 대출 가능한 책은 예약 불가
  
### 예약 취소
<image src="https://user-images.githubusercontent.com/54964209/187381941-6c5da4b3-01c5-4ce2-acbe-94acf03cb019.png">
 
#### 예약중인 도서 예약 취소
* 로그인 상태에서만 이용 가능
* 체크박스 선택한 목록 동시에 취소 가능

### 도서 반납
<image src="https://user-images.githubusercontent.com/54964209/187382577-ce5b8869-d5c0-4a03-af5b-b0abfcf5ddf8.png">
  
#### 대출 상태의 도서 반납
* 로그인 상태에서만 이용 가능
* 체크박스 선택한 목록 동시에 반납 가능
  
### 대출 기록
<image src="https://user-images.githubusercontent.com/54964209/187383947-e0556b15-644f-4fb6-88d3-81d4aa778c3f.png">
<image src="https://user-images.githubusercontent.com/54964209/187383964-20bfbe2a-ad6e-4972-8d59-ee0009a76d67.png">
  
#### 조건을 통해 대출 기록 검색
* 로그인 상태에서만 이용 가능
* 조건을 입력하지 않을 시 모든 기록 출력

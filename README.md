[앱프로그래밍](https://github.com/pmg1020/TIL/tree/main/25%EB%85%84%201%ED%95%99%EA%B8%B0/AppProgramminggit status
)

# VS Code에서 Github 폴더 옮기는 방법
1. git clone <저장소_주소> : Github 저장소를 로컬에 복제
2. mv AppProgramming "25년 1학기/" : AppProgramming -> 25년 1학기 폴더로 옮김
3. git status : 현재 저장소 상태 확인
4. git add . : 모든 변경사항 추가
5. git commit -m "Move AppProgramming folder to 25년 1학기" : 커밋 메세지 입력
6. git push origin main : 원격 저장소로 보내기

## 커밋 메세지를 입력하는 이유
- git log --oneline : 변경 이력을 쉽게 이해할 수 있음
- git revert -n <로그_코드> : 커밋을 되돌릴 수 있음



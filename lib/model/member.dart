/// 성별 열거형 (남성, 여성, 기타)
enum Gender { male, female, other }

/// 헬스 트레이너 회원 관리용 모델 클래스
class Member {
  final String id; // 고유 ID (예: UUID)
  String? photoUrl; // 회원 사진 (URL 또는 로컬 경로)
  String name; // 이름
  String phone; // 전화번호
  Gender gender; // 성별
  DateTime birthDate; // 생년월일
  DateTime registrationDate; // 회원 등록일
  DateTime? sessionStartDate; // PT 수업 시작일
  DateTime? sessionEndDate; // PT 수업 종료일
  List<String> ptGoal; // PT 목표 (예: 다이어트, 체력 향상), 다중 선택 가능
  int sessionCount; // 수업 횟수
  int currentSessionCount; // 현재 수업 횟수
  String? notes; // 특이사항 (예: 무릎 통증 등)
  DateTime createdAt; // 데이터 생성일
  DateTime updatedAt; // 데이터 마지막 수정일

  Member({
    required this.id,
    this.photoUrl,
    required this.name,
    required this.phone,
    required this.gender,
    required this.birthDate,
    required this.registrationDate,
    this.sessionStartDate,
    this.sessionEndDate,
    required this.ptGoal,
    required this.sessionCount,
    required this.currentSessionCount,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
}

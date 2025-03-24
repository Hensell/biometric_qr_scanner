abstract class QrListRepository {
  Future<List<Map<String, dynamic>>> getScannedCodes();
  Future<void> deleteCode(int id);
}

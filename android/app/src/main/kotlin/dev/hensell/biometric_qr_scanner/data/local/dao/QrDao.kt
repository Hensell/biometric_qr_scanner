package dev.hensell.biometric_qr_scanner.data.local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Delete
import dev.hensell.biometric_qr_scanner.data.local.entity.QrEntity

@Dao
interface QrDao {

    @Insert
    suspend fun insert(qr: QrEntity)

    @Query("SELECT * FROM qr_table ORDER BY scannedAt DESC")
    suspend fun getAll(): List<QrEntity>

    @Query("DELETE FROM qr_table WHERE id = :id")
    suspend fun deleteById(id: Int)
}

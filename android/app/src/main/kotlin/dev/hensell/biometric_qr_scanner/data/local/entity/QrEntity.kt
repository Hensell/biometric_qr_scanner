package dev.hensell.biometric_qr_scanner.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "qr_table")
data class QrEntity(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val code: String,
    val scannedAt: Long = System.currentTimeMillis()
)

package dev.hensell.biometric_qr_scanner.data.local.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import dev.hensell.biometric_qr_scanner.data.local.dao.QrDao
import dev.hensell.biometric_qr_scanner.data.local.entity.QrEntity

@Database(entities = [QrEntity::class], version = 1)
abstract class QrDatabase : RoomDatabase() {

    abstract fun qrDao(): QrDao

    companion object {
        @Volatile
        private var INSTANCE: QrDatabase? = null

        fun getInstance(context: Context): QrDatabase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    QrDatabase::class.java,
                    "qr_scanner.db"
                ).build()
                INSTANCE = instance
                instance
            }
        }
    }
}

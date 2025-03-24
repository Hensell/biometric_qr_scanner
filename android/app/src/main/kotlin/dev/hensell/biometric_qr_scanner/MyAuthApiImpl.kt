package dev.hensell.biometric_qr_scanner

import androidx.fragment.app.FragmentActivity
import android.content.Context
import android.content.SharedPreferences
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import dev.hensell.biometric_qr_scanner.AuthApi
import java.util.concurrent.Executor

class MyAuthApiImpl(private val context: Context, private val activity: FragmentActivity) : AuthApi {

    private val sharedPreferences: SharedPreferences by lazy {
        context.getSharedPreferences("secure_prefs", Context.MODE_PRIVATE)
    }

    override fun authenticateWithBiometrics(callback: (Result<Boolean>) -> Unit) {
        val executor: Executor = ContextCompat.getMainExecutor(context)
        val promptInfo = BiometricPrompt.PromptInfo.Builder()
            .setTitle("Autenticación requerida")
            .setSubtitle("Usa tu huella o rostro")
            .setNegativeButtonText("Cancelar")
            .build()

        val biometricPrompt = BiometricPrompt(activity, executor,
            object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                    callback(Result.success(true))
                }

                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    callback(Result.success(false))
                }

                override fun onAuthenticationFailed() {
                    callback(Result.success(false))
                }
            })

        biometricPrompt.authenticate(promptInfo)
    }

    override fun isBiometricAvailable(callback: (Result<Boolean>) -> Unit) {
        val biometricManager = BiometricManager.from(context)
        val isAvailable = biometricManager.canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_STRONG) ==
                BiometricManager.BIOMETRIC_SUCCESS
        callback(Result.success(isAvailable))
    }

    override fun savePin(pin: String, callback: (Result<Boolean>) -> Unit) {
        val success = sharedPreferences.edit().putString("pin", pin).commit()
        callback(Result.success(success))
    }

    override fun isPinSet(callback: (Result<Boolean>) -> Unit) {
        val isSet = sharedPreferences.contains("pin")
        callback(Result.success(isSet))
    }

    override fun validatePin(pin: String, callback: (Result<Boolean>) -> Unit) {
        val savedPin = sharedPreferences.getString("pin", null)
        callback(Result.success(savedPin == pin))
    }
}

package com.game.yangjataegil.flutter_balance_game_client

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle

class MainActivity : FlutterActivity() {
    private val CHANNEL = "yangjataekil.detail/channel"
    private var startString: String? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "initialLink") {
                if (startString != null) {
                    result.success(startString)
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent = getIntent()
        startString = intent.data?.toString()
    }
}


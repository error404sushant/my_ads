package com.example.native_ui_flutter

import android.content.Context
import android.os.Build.VERSION_CODES.R
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.TextView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class CustomNativeView(context: Context) : PlatformView {

    private val view: View

    init {
        val inflater = LayoutInflater.from(context)
        view = inflater.inflate(R.layout.native_layout, null, false)

        val textView: TextView = view.findViewById(R.id.native_text)
        val button: Button = view.findViewById(R.id.native_button)

        button.setOnClickListener {
            textView.text = "Button Clicked!"
        }
    }

    fun getView(): View {
        return view
    }

    fun dispose() {}
}

class CustomNativeViewFactory : PlatformViewFactory(BinaryMessenger) {
    fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return CustomNativeView(context)
    }
}

class MainActivity : FlutterActivity() {

    fun configureFlutterEngine() {
        super.configureFlutterEngine()

        platformViewRegistry.registerViewFactory("native-ui", CustomNativeViewFactory())
    }
}

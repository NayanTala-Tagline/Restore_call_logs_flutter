package com.example.call_log_demo

import android.Manifest
import android.content.ContentValues
import android.content.pm.PackageManager
import android.os.Build
import android.provider.CallLog
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import be.tramckrijte.workmanager.BackgroundWorker.Companion.TAG
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.function.Consumer


class MainActivity: FlutterActivity() {
    private val channel = "samples.flutter.dev/calllogs"

    private val CALL_LOG_PERMISSION_REQUEST_CODE = 101

//    Map<CallType, String> getCallTypeString = {
//        CallType.incoming: "incoming",
//        CallType.outgoing: "outgoing",
//        CallType.missed: "missed",
//        CallType.rejected: "rejected",
//        CallType.blocked: "blocked",
//        CallType.answeredExternally: "answeredExternally",
//        CallType.unknown: "unknown",
//        CallType.wifiIncoming: "wifiIncoming",
//        CallType.wifiOutgoing: "wifiOutgoing"
//    };

    val callType = mutableMapOf(
        "incoming" to CallLog.Calls.INCOMING_TYPE,
        "outgoing" to CallLog.Calls.OUTGOING_TYPE,
        "missed" to CallLog.Calls.MISSED_TYPE,
        "rejected" to CallLog.Calls.REJECTED_TYPE,
        "blocked" to CallLog.Calls.BLOCKED_TYPE,
        "answeredExternally" to CallLog.Calls.ANSWERED_EXTERNALLY_TYPE,
        "unknown" to CallLog.Calls.PRESENTATION_UNKNOWN,
        "wifiIncoming" to CallLog.Calls.FEATURES_WIFI,
        "wifiOutgoing" to CallLog.Calls.FEATURES_WIFI,
    )

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->

            if (call.method == "writeCallLog") {
//                enableRuntimePermissionToAccessCallLogs()
                val arguments = call.arguments as List<*>



//                arguments.forEach { e -> print("$e ") }
//                val keyValue = arguments["key"]
                for (i in arguments.indices) {
                    if (arguments[i] is Map<*, *>) {
                        println(arguments[i])
                        arguments.forEach { System.out.print("bndsf $it") }
                        writeCallLog(arguments[i] as Map<*, *>)
                    } else {
                        // Handle the case when the element is not a Map<*, *>
                    }
                }
                result.success("Call Log Written Successfully")
            } else {
                result.notImplemented()
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun writeCallLog(args: Map<*,*>) {



        val values = ContentValues()
//        if(args["callType"] == "outgoing"){
//            = CallLog.Calls.OUTGOING_TYPE
//        }

//        values.put(CallLog.Calls.NUMBER, "9876543210");
//        values.put(CallLog.Calls.DATE, System.currentTimeMillis());
//        values.put(CallLog.Calls.DURATION, 55);
//        values.put(CallLog.Calls.TYPE, CallLog.Calls.OUTGOING_TYPE);
//        values.put(CallLog.Calls.NEW, 1);
//        values.put(CallLog.Calls.CACHED_NAME, "Testttt");
//        values.put(CallLog.Calls.CACHED_NUMBER_TYPE, 2);
//        values.put(CallLog.Calls.CACHED_NUMBER_LABEL, "tv12");


        values.put(CallLog.Calls.NUMBER, args["number"] as? String)
        values.put(CallLog.Calls.DATE, args["timestamp"] as? Long)
        values.put(CallLog.Calls.DURATION, args["duration"] as? Int)
        values.put(CallLog.Calls.TYPE, callType[args["callType"]])
        values.put(CallLog.Calls.NEW, 1)
        values.put(CallLog.Calls.CACHED_NAME, "")
        values.put(CallLog.Calls.CACHED_NUMBER_TYPE, args["cachedNumberType"] as? Int)
        values.put(CallLog.Calls.CACHED_NUMBER_LABEL, args["cachedNumberLabel"] as? Int)
        values.put(CallLog.Calls.CACHED_MATCHED_NUMBER, args["cachedMatchedNumber"] as? String)

        context.contentResolver.insert(CallLog.Calls.CONTENT_URI, values)

    }

    private fun getCallType(callType:String){

    }


    private fun enableRuntimePermissionToAccessCallLogs() {

        Log.i(TAG, "EnableRuntimePermissionToAccessCallLogs called")
        if (ActivityCompat.checkSelfPermission(
                activity,
                Manifest.permission.WRITE_CALL_LOG
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            Log.i(TAG, "giving write call log permission")
            ActivityCompat.requestPermissions(
                activity, arrayOf<String>(Manifest.permission.WRITE_CALL_LOG),
                1
            )
            Log.i(TAG, "giving write call log permission 2")
        }
        Log.i(TAG, "EnableRuntimePermissionToAccessCallLogs called 2")
    }


}
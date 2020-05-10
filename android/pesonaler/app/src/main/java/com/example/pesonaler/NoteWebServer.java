package com.example.pesonaler;

import android.util.Log;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Map;

import fi.iki.elonen.NanoHTTPD;

public class NoteWebServer extends NanoHTTPD {

    public static final String HTTP_BADREQUEST = "400 Bad Request";
    public static final String HTTP_FORBIDDEN = "403 Forbidden";
    public static final String HTTP_INTERNALERROR = "500 Internal Server Error";
    public static final String HTTP_NOTFOUND = "404 Not Found";
    public static final String HTTP_NOTIMPLEMENTED = "501 Not Implemented";
    public static final String HTTP_NOTMODIFIED = "304 Not Modified";
    public static final String HTTP_OK = "200 OK";
    public static final String HTTP_PARTIALCONTENT = "206 Partial Content";
    public static final String HTTP_RANGE_NOT_SATISFIABLE = "416 Requested Range Not Satisfiable";
    public static final String HTTP_REDIRECT = "301 Moved Permanently";

    public static final String
            MIME_PLAINTEXT = "text/plain",
            MIME_HTML = "text/html",
            MIME_JS = "application/javascript",
            MIME_CSS = "text/css",
            MIME_PNG = "image/png",
            MIME_DEFAULT_BINARY = "application/octet-stream",
            MIME_XML = "text/xml";

    public static final String MIME_JAVASCRIPT = "text/javascript";
    public static final String MIME_JPEG = "image/jpeg";
    public static final String MIME_SVG = "image/svg+xml";
    public static final String MIME_JSON = "application/json";
    public static final String MIME_GIF = "image/gif";

    public NoteWebServer() {
        super(8080);
    }

    @Override
    public NanoHTTPD.Response serve(IHTTPSession session) {
        String answer = "";
        String uri = null;
        uri = session.getUri();
        Log.d("jimmy","uri = " +uri);
        Log.d("jimmy","uri substring(1)= " +uri.substring(1));

        InputStream mbuffer = null;
        if(uri.equals("/")) {
//                try {
//                    BufferedReader reader = null;
//                    try {
//
//                        reader = new BufferedReader(new InputStreamReader(mContext.getAssets().open("index.html")));
//                    } catch (IOException e) {
//                        e.printStackTrace();
//                    }
//
//                    String line = "";
//                    while ((line = reader.readLine()) != null) {
//                        answer += line + "\n";
//                    }
//                    reader.close();
//
//                } catch(IOException ioe) {
//                    Log.w("Httpd", ioe.toString());
//                }
//
//
//                return newFixedLengthResponse(answer);
            String msg = "<html><body><h1>Hello new 1 server</h1>\n";
            Map<String, String> parms = session.getParms();
            if (parms.get("username") == null) {
                msg += "<form action='?' method='get'>\n  <p>Your name: <input type='text' name='username'></p>\n" + "</form>\n";
            } else {
                msg += "<p>Hello, " + parms.get("username") + "!</p>";
            }
            return newFixedLengthResponse(msg + "</body></html>\n");
        }else if(uri.endsWith("js")){

            //Log.i("jimmy","it's javascript file");
//            try {
//                mbuffer = mContext.getAssets().open(uri.substring(1));
//                try {
//                    BufferedReader reader = null;
//                    try {
//                        String [] list = null;
//
//                        reader = new BufferedReader(new InputStreamReader(mContext.getAssets().open(uri.substring(1))));
//                    } catch (IOException e) {
//                        e.printStackTrace();
//                    }
//
//                    String line = "";
//                    while ((line = reader.readLine()) != null) {
//                        answer += line + "\n";
//                    }
//                    reader.close();
//
//                } catch(IOException ioe) {
//                    Log.w("Httpd", ioe.toString());
//                }
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//            return newFixedLengthResponse(answer);

        }else if(uri.endsWith("gif") || uri.endsWith("png")){
//            Log.d("jimmy","It's png & gif file");
//
//            InputStream is = null;
//            try {
//                is = mContext.getAssets().open(uri.substring(1));
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//
//            //Response newChunkedResponse(IStatus status, String mimeType, InputStream data)
//            return newChunkedResponse(Response.Status.OK, MIME_PNG, is);
        }else{
            //newFixedLengthResponse(NanoHTTPD.Response.IStatus status, String mimeType, String message)
            //return newFixedLengthResponse(HTTP_NOTFOUND, String mimeType, String txt);
            //return newFixedLengthResponse(HTTP_NOTFOUND, String mimeType, String message);
        }

        Method method = session.getMethod();
        Log.d("jimmy","method = "+method);
        //public static Response newFixedLengthResponse(IStatus status, String mimeType, String txt) {
        //return newFixedLengthResponse(IStatus status, String mimeType, String txt);
        return newFixedLengthResponse(answer);
    }

}

package anative.hackit2017.com.apiclient;

import android.os.AsyncTask;
import android.util.Log;

public class Api {

    static class C00012 extends AsyncTask<Void, Void, String> {
        C00012() {
        }

        protected String doInBackground(Void... voids) {
            return new Client("info").addPost("personal_key", MainActivity.regKey).send();
        }

        protected void onPostExecute(String response) {
            Log.i("ServerAPI", response);
            MainActivity.toast(response.contains("login_admin") ? "ok" : "no");
        }
    }

    public static void register(final String name) {
        new AsyncTask<Void, Void, String>() {
            protected String doInBackground(Void... voids) {
                return new Client("register").addPost("name", name).send();
            }

            protected void onPostExecute(String response) {
                MainActivity.regKey = response.replace("personal_key=", "");
                Log.i("ServerAPI", response);
                MainActivity.toast(response.contains("personal_key") ? "ok" : "no");
            }
        }.execute(new Void[0]);
    }

    public static void getInfo() {
        new C00012().execute(new Void[0]);
    }
}

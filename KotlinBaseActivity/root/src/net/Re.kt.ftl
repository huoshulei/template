package ${packageName}.net


import ${packageName}.utlis.log.HttpLoggingInterceptor


import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

object Re {
	private val BASE_URL = "${BASE_URL}"
    val api: ApiService by lazy {
        getInstance()
    }

    private fun getInstance(): ApiService {
        val client = OkHttpClient.Builder()
                .connectTimeout(30, TimeUnit.SECONDS)
                .addInterceptor(HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY))
                .addNetworkInterceptor { chain ->
                    val request = chain.request()
                    if (request.body() == null || request.header("Authorization") != null) {
                        return@addNetworkInterceptor chain.proceed(request)
                    }
                    val requestBuilder = request.newBuilder()
                            .addHeader("Authorization", "")
                    chain.proceed(requestBuilder.build())
                }
                .build()
        return Retrofit.Builder()
                .baseUrl(BASE_URL)
                .client(client)
                .addCallAdapterFactory(SingleFactory.createIO())
                .addConverterFactory(GsonConverterFactory.create())
                .build()
                .create(ApiService::class.java)

    }

}

package ${packageName}.base


import ${packageName}.utlis.log.L
import ${packageName}.net.*

import com.google.gson.JsonParseException

import org.json.JSONException

import java.net.ConnectException
import java.net.SocketException
import java.net.SocketTimeoutException
import java.text.ParseException

import io.reactivex.observable.Single


/**
 * 创建者： huoshulei
 * 时间：   ${lastUpdated?string.medium_short} <＃ - 中等日期，短时间 - >
 */

abstract class BasePresenter(private val progress: OnProgress) {

	protected val api by lazy { Re.api }

    private fun <T> Single<T>.map(): Single<T> {
        return map { it }
    }

   fun <T> Single<T>.subscribe(onNext: (T) -> Unit, onError: (Throwable) -> Unit={}) {
        progress.addDisposable(doOnSubscribe { progress.showProgress() }
                .map()
                .onErrorResumeNext { handleException(it) }
                .observeOn(AndroidSchedulers.mainThread())
                .doOnError {
                    onError(it)
                    progress.onError(it.message ?: "忽略")
                    progress.dismissProgress()
                }
                .subscribe { it ->
                    onNext(it)
                    progress.dismissProgress()
                })

    }

    private fun <T> handleException(e: Throwable): Single<T> {
        L.d("BaseViewModule:" + e.toString())
        val ex: ApiException
        if (e is HttpException) {
            when (e.code()) {
                400 -> ex = ApiException("请求错误!请求中有语法错误")
                402 -> ex = ApiException("需要付费")
                403 -> ex = ApiException("禁止访问!")
                404 -> ex = ApiException("访问目标不存在或已被删除")
                405 -> ex = ApiException("资源被禁止")
                406 -> ex = ApiException("请求错误!请求中有语法错误")
                407 -> ex = ApiException("需要代理身份认证")
                410 -> ex = ApiException("资源不可用")
                414 -> ex = ApiException("请求路径过长")
                500 -> ex = ApiException("服务器繁忙!暂不接受访问")
                502 -> ex = ApiException("网关错误")
                else -> ex = ApiException("网络错误")
            }
        } else if (e is JSONException
                || e is JsonParseException
                || e is ParseException) {
            ex = ApiException("数据解析异常")
        } else if (e is ConnectException) {
            ex = ApiException("服务器连接失败")
        } else if (e is TokenException || e is ServeException) {
            ex = ApiException(e.message)
        } else if (e is SocketException) {
            ex = ApiException("无法连接到服务器")
        } else if (e is SocketTimeoutException) {
            ex = ApiException("连接超时")
        } else if (e is NullPointerException) {
            ex = ApiException(e.message)
        } else {
            ex = ApiException("未知错误")
        }
        return Single.error<T>(ex)
    }

}

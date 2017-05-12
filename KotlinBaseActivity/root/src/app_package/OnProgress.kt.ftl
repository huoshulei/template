package ${applicationPackage}.base

import io.reactivex.common.Disposable
import io.reactivex.common.internal.disposables.ListCompositeDisposable


interface OnProgress {
    val disposables: ListCompositeDisposable

    fun showProgress()

    fun dismissProgress()

    fun onError(message: String)

    fun addDisposable(disposable: Disposable) {
        disposables.add(disposable)
    }

    fun remove(disposable: Disposable) {
        disposables.remove(disposable)
    }

    fun clear() {
        disposables.clear()
    }
}

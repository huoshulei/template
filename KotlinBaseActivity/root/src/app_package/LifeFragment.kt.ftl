package ${packageName}.base

import io.reactivex.common.Disposable
import io.reactivex.common.internal.disposables.ListCompositeDisposable


abstract class LifeFragment<out T:BaseFragmentComponent, out P : BasePresenter> : BaseFragment<T>(), OnProgress {
    protected abstract val presenter:P
    override val disposables by lazy { ListCompositeDisposable() }

    override fun showProgress() {
        showDialog()
    }

    override fun dismissProgress() {
        hideDialog()
    }

    override fun onError(message: String) {
        tt(message)
    }

    override fun onDestroy() {
        clear()
        super.onDestroy()
    }
}
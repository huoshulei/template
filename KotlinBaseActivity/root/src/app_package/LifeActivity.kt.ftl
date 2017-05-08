package ${packageName}.base

import io.reactivex.common.internal.disposables.ListCompositeDisposable


abstract class LifeActivity<A : LifeActivity<A, T, P>, out T : BaseComponent<A>, out P : BasePresenter>
    : BaseActivity<A, T>(), OnProgress {
    protected abstract val presenter: P
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

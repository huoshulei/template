package ${applicationPackage}.base

import android.app.Dialog
import android.app.Fragment
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

import com.growingio.android.sdk.collection.GrowingIO
import org.jetbrains.anko.*

/**
 * 创建者：
 * 时间：  
 */
abstract class BaseFragment<out T : BaseFragmentComponent> : Fragment() {
    abstract val component: T
    private val rootView by lazy { component.createView(this).view }
    private var isFirstInit: Boolean? = true
    private val dialog by lazy {
        with(Dialog(ctx)) {
            setContentView(View(context), ViewGroup.LayoutParams(0, 0))
            setCancelable(true)
            setCanceledOnTouchOutside(false)
            this
        }
    }
    private var isFirstVisible = true
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GrowingIO.getInstance().setPageName(this, javaClass.simpleName)


    }


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return rootView
    }

    override fun onViewCreated(view: View?, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        if (isFirstVisible) {
            isFirstInit = false
            configView(rootView)
            handleEvent()
            initData()
        }
    }

    /**
     * 初始化布局组件
     */
    open fun configView(view: View) {

    }

    /**
     * 触控事件
     */
    open fun handleEvent() {
    }

    /*数据初始化*/
    open fun initData() {

    }

    /**
     * 首次可见
     */
    open fun onFirstVisible() {
    }

    override fun setUserVisibleHint(isVisibleToUser: Boolean) {
        super.setUserVisibleHint(isVisibleToUser)
        if (isVisibleToUser) {
            if (isFirstVisible) {
                isFirstVisible = false
                onFirstVisible()
            }
        }
    }

    protected fun hideDialog() {
        dialog.hide()
    }

    protected fun showDialog() {
        dialog.show()
    }


    override fun onDestroy() {
        dialog.dismiss()
        super.onDestroy()
    }

    fun tt(message: String) {
        toast(message)
    }
}
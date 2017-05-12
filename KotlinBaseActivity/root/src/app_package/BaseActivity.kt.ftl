package ${applicationPackage}.base


import android.app.Dialog
import android.content.Context
import android.content.pm.ActivityInfo
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup

import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import com.growingio.android.sdk.collection.GrowingIO
import ${applicationPackage}.R
import org.jetbrains.anko.*



abstract class BaseActivity<A : BaseActivity<A, T>, out T : AnkoComponent<A>> : AppCompatActivity() {
    abstract val component: T
    private val dialog by lazy {
        with(Dialog(this)) {
            setContentView(View(ctx), ViewGroup.LayoutParams(0, 0))
            setCancelable(true)
            setCanceledOnTouchOutside(false)
            this
        }
    }
    private val im by lazy {
        getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        setTheme(R.style.AppTheme)
        super.onCreate(savedInstanceState)
        requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT //屏幕方向
        GrowingIO.getInstance().setPageName(this, localClassName)
        component.setContentView(this as A)
        configView()
        handleEvent()
        initData()
    }

    open fun configView() {}

    open fun handleEvent() {}

    open fun initData() {}


    protected fun hideDialog() {
        dialog.hide()
    }

    protected fun showDialog() {
        dialog.show()
    }

    fun tt(message: String) {
        toast(message)
    }

    override fun onResume() {
        super.onResume()
    }

    override fun onPause() {
        super.onPause()
    }

    override fun onDestroy() {
        dialog.dismiss()
        super.onDestroy()
    }

    override fun dispatchTouchEvent(ev: MotionEvent): Boolean {
        if (ev.action == MotionEvent.ACTION_DOWN) {
            val v = currentFocus
            if (isShouldHideKeyboard(v, ev)) {
                im.hideSoftInputFromWindow(v.windowToken, InputMethodManager.HIDE_NOT_ALWAYS)
                v.clearFocus()
                //                return true;
            }
        }
        return super.dispatchTouchEvent(ev)
    }

    // 根据EditText所在坐标和用户点击的坐标相对比，来判断是否隐藏键盘
    private fun isShouldHideKeyboard(v: View?, event: MotionEvent): Boolean {
        if (v is EditText) {
            val l = intArrayOf(0, 0)
            v.getLocationInWindow(l)
            val left = l[0]
            val top = l[1]
            val bottom = top + v.height
            val right = left + v.width
            return !(event.x > left && event.x < right
                    && event.y > top && event.y < bottom)
        }
        return false
    }
}

package ${applicationPackage}.base

import android.graphics.Color
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.Toolbar
import android.view.Gravity
import android.view.View
import android.view.ViewManager
import android.widget.LinearLayout
import android.widget.TextView
import com.example.refresh.TwinklingRefreshLayout
import ${applicationPackage}.R
import ${applicationPackage}.widget.SwipeBackLayout
import org.jetbrains.anko.*
import org.jetbrains.anko.appcompat.v7.navigationIconResource
import org.jetbrains.anko.appcompat.v7.toolbar
import org.jetbrains.anko.custom.ankoView

/**
 * 创建者： huoshulei
 * 时间：  2017/5/6.
 */
abstract class BaseComponent<in T : AppCompatActivity> : AnkoComponent<T> {
    abstract val isShowToolbar: Boolean
    var titleText: TextView? = null
    var toolbar: Toolbar? = null
    override fun createView(ui: AnkoContext<T>): View = with(ui) {
        frameLayout {
            val imageView = imageView {
                backgroundResource = R.color.bg_f7
            }.lparams(matchParent, matchParent)
            swipeBackLayout {
                //滑动返回布局
                lparams(matchParent, matchParent)
                setDragEdge(SwipeBackLayout.DragEdge.LEFT)
                setOnSwipeBackListener { _, fl -> imageView.alpha = 1 - fl }
                verticalLayout {
                    dividerDrawable = resources.getDrawable(R.drawable.divider)
                    showDividers = LinearLayout.SHOW_DIVIDER_MIDDLE
                    backgroundResource = R.color.alpha_white
                    if (isShowToolbar)//是否显示toolbar
                        toolbar = toolbar {
                            lparams(matchParent, dip(44)) { }
                            titleText = textView {
                                lines = 1
                                textColor = Color.BLACK
                                gravity = Gravity.CENTER
                                textSize = 18f
                            }.lparams(wrapContent, dip(43)) {
                                gravity = Gravity.CENTER
                            }
                            ui.owner.setSupportActionBar(this)
                            ui.owner.supportActionBar?.setDisplayShowTitleEnabled(false)
                            navigationIconResource = R.mipmap.detail_back
                            setNavigationOnClickListener { ui.owner.onBackPressed() }
                        }
                    contentView(this@with.owner)
                }
            }
        }
    }

    abstract fun _LinearLayout.contentView(activity: T)

}

inline fun ViewManager.swipeBackLayout(theme: Int = 0, init: SwipeBackLayout.() -> Unit): SwipeBackLayout {
    return ankoView({ SwipeBackLayout(it) }, theme) { init() }
}
inline fun ViewManager.twinklingRefreshLayout(theme: Int = 0, init: TwinklingRefreshLayout.() -> Unit): TwinklingRefreshLayout {
    return ankoView({ TwinklingRefreshLayout(it) }, theme) { init() }
}
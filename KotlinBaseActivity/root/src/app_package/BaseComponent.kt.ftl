package ${packageName}.base

import android.graphics.Color
import android.support.v7.widget.Toolbar
import android.view.Gravity
import android.view.View
import android.view.ViewManager
import android.widget.LinearLayout
import android.widget.TextView
import ${packageName}.R
import ${packageName}.widget.SwipeBackLayout
import org.jetbrains.anko.*
import org.jetbrains.anko.appcompat.v7.navigationIconResource
import org.jetbrains.anko.appcompat.v7.toolbar
import org.jetbrains.anko.custom.ankoView

/**
 * 创建者： huoshulei
 * 时间：   ${lastUpdated?string.medium_short} <＃ - 中等日期，短时间 - >
 */
abstract class BaseComponent<T : AppCompatActivity> : AnkoComponent<T> {
    abstract val isShowToolbar: Boolean
    protected var title: TextView? = null
    protected var toolbar: Toolbar? = null
    override fun createView(ui: AnkoContext<T>): View = with(ui) {
        frameLayout {
            val imageView = imageView {
                lparams(matchParent, matchParent)
                backgroundResource = R.color.bg_f7
            }
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
                            this@BaseComponent.title = textView {
                                lparams(wrapContent, dip(43)) {
                                    gravity = Gravity.CENTER
                                }
                                lines = 1
                                textColor = Color.BLACK
                                gravity = Gravity.CENTER
                                textSize = 18f
                            }
                            ui.owner.setSupportActionBar(this)
                            ui.owner.supportActionBar?.setDisplayShowTitleEnabled(false)
                            navigationIconResource = R.mipmap.detail_back
                            setNavigationOnClickListener { ui.owner.onBackPressed() }
                        }
                    contentView(this@with)
                }
            }
        }
    }

    abstract fun contentView(ui: AnkoContext<T>)

    inline fun ViewManager.swipeBackLayout(theme: Int = 0, init: SwipeBackLayout.() -> Unit): SwipeBackLayout {
        return ankoView({ SwipeBackLayout(it) }, theme) { init() }
    }
}

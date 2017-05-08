package ${packageName}.base

import android.app.Fragment
import org.jetbrains.anko.*

/**
 * 创建者： huoshulei
 * 时间：   ${lastUpdated?string.medium_short} <＃ - 中等日期，短时间 - >
 */
abstract class BaseFragmentComponent {

    abstract fun createView(ui: AnkoContext<Fragment>)

}

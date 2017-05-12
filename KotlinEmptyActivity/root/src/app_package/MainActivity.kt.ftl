package ${packageName};

import ${applicationPackage}.base.BaseActivity
import org.jetbrains.anko.*
/**
 * 创建者：
 * 时间：  
 */
class UserActivity(override val component: UserComponent = UserComponent()) 
    : BaseActivity<UserActivity, UserComponent>() {

	 override fun configView() {
		component.titleText?.textResource = R.string.title_${activityToLayout(activityClass)}
      
    }
}
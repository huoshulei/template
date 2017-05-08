package ${packageName};

import ${applicationPackage}.base.LifeFragment

/**
 * 创建者：
 * 时间：   
 */
class ${className}(override val component: ${componentClass} = ${componentClass}()) 
	: LifeFragment<${componentClass}, ${presenterClass}>() {
    override val presenter by lazy { ${presenterClass}(this) }
}
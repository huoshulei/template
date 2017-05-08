package ${packageName}.base

import android.content.Context
import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup

abstract class BaseAdapter<T>(private var isFooter: Boolean = false,
                              private val mData: MutableList<T> = mutableListOf<T>())
    : RecyclerView.Adapter<ViewHolder>() {

 protected var mContext: Context? = null
    private val FOOTER = 50
    private val DEFAULT = 0
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        if (mContext == null) mContext = parent.context
        when (viewType) {
            FOOTER -> return ViewHolder(footerView(mContext!!))
            else -> return ViewHolder(convertView(mContext!!))
        }
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        when (holder.itemViewType) {
            FOOTER -> footer(holder)
            DEFAULT -> convert(holder, mData[position])
        }
    }

    abstract fun convert(holder: ViewHolder, item: T)
    abstract fun convertView(context: Context): View
    fun footer(holder: ViewHolder) {}
    fun footerView(context: Context): View {
        throw NullPointerException("null view ")
    }

    override fun getItemViewType(position: Int): Int {
        if (isFooter && position == itemCount - 1) return FOOTER
        return DEFAULT
    }

    override fun getItemCount(): Int {
        return mData.size + if (isFooter) 1 else 0
    }

    private fun setFooter(footer: Boolean) {
        isFooter = footer
    }

    /**
     * @param data 添加数据
     */
    fun setData(data: List<T>) {
        clear()
        mData.addAll(data)
        notifyItemRangeInserted(0, mData.size)
    }

    /**
     * @param data 添加数据
     */
    fun addData(data: List<T>) {
        if (data.isEmpty()) {
            return
        }
        val count = mData.size
        mData.addAll(data)
        notifyItemRangeInserted(count, data.size)
    }

    /**
     * @param data 添加数据
     */
    fun addData(data: T) {
        val count = mData.size
        mData.add(data)
        notifyItemInserted(count)
    }

    /**
     * @param data 添加数据
     */
    fun addData(data: List<T>, position: Int) {
        if (data.isEmpty()) {
            return
        }
        mData.addAll(data)
        notifyItemRangeInserted(position, data.size)
    }

    /**
     * @param data 添加数据
     */
    fun addData(data: T, position: Int) {
        mData.add(position, data)
        notifyItemInserted(position)
    }

    /**
     * 清空适配器数据
     */
    fun clear() {
        mData.clear()
        notifyDataSetChanged()
    }

    /**
     * @param position 删除角标为position的数据
     */
    fun remove(position: Int) {
        mData.removeAt(position)
        notifyItemRemoved(position)
    }

    /**
     * @param data 删除指定数据
     */
    fun remove(data: T) {
        val index = mData.indexOf(data)
        if (index >= 0) remove(index)
    }

    fun getData(): MutableList<T> {
        return mData
    }
}
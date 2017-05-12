package ${applicationPackage}.base

import android.graphics.Bitmap
import android.graphics.Typeface
import android.graphics.drawable.Drawable
import android.support.annotation.*
import android.support.v7.widget.RecyclerView
import android.text.util.Linkify
import android.util.SparseArray
import android.view.View
import android.widget.ImageView
import android.widget.TextView

class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    private val views by lazy { SparseArray<View>() }

    fun setText(@IdRes viewId: Int, text: CharSequence?): ViewHolder {
        val view = getView(viewId)
        if (view is TextView) {
            view.text = text ?: ""
            return this
        }
        throw ClassCastException("目标不是TextView")
    }

    fun setText(@IdRes viewId: Int, @StringRes resId: Int): ViewHolder {
        val view = getView(viewId)
        if (view is TextView) {
            view.setText(resId)
            return this
        }
        throw ClassCastException("目标不是TextView")
    }

    fun setImageResource(@IdRes viewId: Int, @DrawableRes resId: Int): ViewHolder {
        val view = getView(viewId)
        if (view is ImageView) {
            view.setImageResource(resId)
            return this
        }
        throw ClassCastException("目标不是ImageView")
    }

    //    /**
    //     * @param url A file path, or a uri or url handled by {@link com.bumptech.glide.load.model.UriLoader}.
    //     */
    //    public BaseViewHolder setImageUrl(@IdRes int viewId, String url) {
    //        View view = getView(viewId);
    //        if (view instanceof ImageView) {
    //            Glide.with(view.getContext())
    //                    .load(url).into((ImageView) view);
    //            return this;
    //        }
    //        throw new ClassCastException("目标不是ImageView");
    //    }

    fun setBackgrounColor(@IdRes viewId: Int, @ColorInt color: Int): ViewHolder {
        getView(viewId).setBackgroundColor(color)
        return this
    }

    fun setBackgroundResource(viewId: Int, @DrawableRes backgroundRes: Int): ViewHolder {
        getView(viewId).setBackgroundResource(backgroundRes)
        return this
    }

    fun setTextColor(@IdRes viewId: Int, @ColorInt color: Int): ViewHolder {
        val view = getView(viewId)
        if (view is TextView) {
            view.setTextColor(color)
            return this
        }
        throw ClassCastException("目标不是TextView")
    }

    fun setImageDrawable(@IdRes viewId: Int, drawable: Drawable): ViewHolder {
        val view = getView(viewId)
        if (view is ImageView) {
            view.setImageDrawable(drawable)
            return this
        }
        throw ClassCastException("目标不是ImageView")
    }

    fun setImageBitmap(@IdRes viewId: Int, bitmap: Bitmap): ViewHolder {
        val view = getView(viewId)
        if (view is ImageView) {
            view.setImageBitmap(bitmap)
            return this
        }
        throw ClassCastException("目标不是ImageView")
    }

    fun setAlpha(@IdRes viewId: Int, alpha: Float): ViewHolder {
        getView(viewId).alpha = alpha
        return this
    }

    fun setVisible(@IdRes viewId: Int, @Visibility visibility: Int): ViewHolder {
        getView(viewId).visibility = visibility
        return this
    }

    fun linkify(@IdRes viewId: Int): ViewHolder {
        val view = getView(viewId)
        if (view is TextView) {
            Linkify.addLinks(view, Linkify.ALL)
            return this
        }
        throw ClassCastException("目标不是ImageView")
    }

    fun setTypeface(@IdRes viewId: Int, typeface: Typeface): ViewHolder {
        val view = getView(viewId)
        if (view is TextView) {
            view.typeface = typeface
            view.paintFlags = view.paintFlags or 128
            return this
        }
        throw ClassCastException("目标不是TextView")
    }

    fun setTypeface(typeface: Typeface, @IdRes vararg viewId: Int): ViewHolder {
        for (id in viewId) {
            setTypeface(id, typeface)
        }
        return this
    }


    fun setOnClickListener(@IdRes viewId: Int, listener: View.OnClickListener): ViewHolder {
        getView(viewId).setOnClickListener(listener)
        return this
    }

    fun setOnClickListener(listener: View.OnClickListener, @IdRes vararg viewIds: Int): ViewHolder {
        for (id in viewIds) {
            getView(id).setOnClickListener(listener)
        }
        return this
    }

    fun setOnLongClickListener(@IdRes viewId: Int, listener: View.OnLongClickListener): ViewHolder {
        getView(viewId).setOnLongClickListener(listener)
        return this
    }

    fun getView(@IdRes viewId: Int): View {
        var view = views.get(viewId)
        if (view == null) {
            view = itemView.findViewById(viewId)
            views.put(viewId, view)
        }
        return view
    }

    /**
     * @hide
     */
    @IntDef(View.VISIBLE.toLong(), View.INVISIBLE.toLong(), View.GONE.toLong())
    @Retention(AnnotationRetention.SOURCE)
    internal annotation class Visibility
}

package com.example.pesonaler;


import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import org.w3c.dom.Text;

import java.util.List;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

public class RecycleViewAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context mContent;
    private List<String> mDatas;
    private final int NORMAL_VIEW = 1;
    private final int TEXT_VIEW = 2;
    private final int IMAGE_VIEW = 3;
    private final int VIDEO_VIEW = 4;

    public RecycleViewAdapter(Context context, List<String> datas){
        mContent = context;
        mDatas = datas;
    }

    @Override
    public int getItemViewType(int position) {

        if(position == 1){
            return IMAGE_VIEW;
        }
        else {
            return NORMAL_VIEW;
        }
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        if (viewType == NORMAL_VIEW){

            MyViewHolder holder = new MyViewHolder(LayoutInflater.from(mContent).inflate(R.layout.recycle_view_tem,parent,false));
            return holder;

        }else if(viewType == IMAGE_VIEW){
            TextViewHolder textHolder = new TextViewHolder(LayoutInflater.from(mContent).inflate(R.layout.recyle_view_text,parent,false));
            return textHolder;
        }


        return null;
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, int position) {
        if (holder instanceof MyViewHolder){
            ((MyViewHolder)holder).tv.setText(mDatas.get(position));
        }else if(holder instanceof TextViewHolder){
            ((TextViewHolder) holder).tv.setText("TEXT1asldjflksadjfls;ajflsf"+mDatas.get(position));

            int height_in_pixels = ((TextViewHolder)holder).tv.getLineCount()*((TextViewHolder)holder).tv.getLineHeight();
            ((TextViewHolder)holder).tv.setHeight(400);
            
        }
    }

//    @Override
//    public void onBindViewHolder(@NonNull MyViewHolder holder, int position) {
//
//
//
//    }

    @Override
    public int getItemCount() {

        return mDatas.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder {
        TextView tv;

        public MyViewHolder(View view){
            super(view);
            tv = (TextView) view.findViewById(R.id.id_num);
        }
    }

    public class TextViewHolder extends RecyclerView.ViewHolder {
        TextView tv;

        public TextViewHolder(View view){
            super(view);
            tv = (TextView) view.findViewById(R.id.id_text);
        }
    }
}

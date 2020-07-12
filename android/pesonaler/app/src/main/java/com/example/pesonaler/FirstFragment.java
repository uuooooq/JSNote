package com.example.pesonaler;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.List;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.navigation.fragment.NavHostFragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

public class FirstFragment extends Fragment {

    private RecyclerView mRecycleView;
    private List<String> mDatas;

    @Override
    public View onCreateView(
            LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState
    ) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_first, container, false);
    }

    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

//        view.findViewById(R.id.button_first).setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                NavHostFragment.findNavController(FirstFragment.this)
//                        .navigate(R.id.action_FirstFragment_to_SecondFragment);
//            }
//        });

        initData();
        mRecycleView = (RecyclerView)view.findViewById(R.id.recycleview);
        mRecycleView.setLayoutManager(new LinearLayoutManager(this.getContext()));
        mRecycleView.setAdapter( new RecycleViewAdapter(this.getContext(),mDatas));
    }

    protected void initData(){
        mDatas = new ArrayList<String>();
        for(int i = 1; i < 20; i++){
            mDatas.add(""+i);
        }
    }


}

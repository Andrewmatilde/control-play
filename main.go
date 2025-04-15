package main

import (
	"context"
	"fmt"
	"time"

	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

func main() {
	// 1. 在Pod内运行时，自动使用ServiceAccount
	config, err := rest.InClusterConfig()
	if err != nil {
		panic(err)
	}

	// 2. 创建clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		panic(err)
	}

	// 3. 使用clientset进行API调用
	// 例如：获取Pod列表
	for {
		pods, err := clientset.CoreV1().Pods("default").List(context.TODO(), metav1.ListOptions{})
		if err != nil {
			panic(err)
		}
		fmt.Println(pods)
		time.Sleep(30 * time.Second)
	}
}

import type { HostComponent, ViewProps } from "react-native";
import { Double, WithDefault } from 'react-native/Libraries/Types/CodegenTypes';
import codegenNativeComponent from "react-native/Libraries/Utilities/codegenNativeComponent";

export interface NativeProps extends ViewProps {
  shimmerColor?: string; // Hex color for the shimmer background
  highlightColor?: string; // Hex color for the shimmer highlight
  animationDuration?: Double; // Duration of the shimmer animation in seconds
  shimmerDirection?: WithDefault<"leftToRight" | "rightToLeft" | "topToBottom" | "bottomToTop", 'leftToRight'>; // Direction of the shimmer animation
}

export default codegenNativeComponent<NativeProps>("RNPlaceholder") as HostComponent<NativeProps>;
